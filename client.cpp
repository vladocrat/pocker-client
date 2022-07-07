#include <QDataStream>
#include <QtCore>
#include <QDebug>
#include <cassert>

#include "client.h"
#include "fieldmanager.h"
#include "user.h"
#include "room.h"
#include "../common/LoginData.h"
#include "../common/protocol.h"
#include "../common/Message.h"

Client::Client()
{
    m_socket = new QTcpSocket;
    connectHost();
    connect(m_socket, &QTcpSocket::readyRead, this, &Client::read);
}

Client::~Client()
{
    assert(m_socket);
    m_socket->close();
    m_socket->deleteLater();
}

void Client::connectHost()
{
    m_socket->connectToHost(address, port, QIODevice::ReadWrite);
}

bool Client::sendCommand(int command)
{
    if (!checkConnection()) return false;

    QByteArray msg;
    QDataStream stream(&msg, QIODevice::WriteOnly);
    QDataStream socketStream(m_socket);
    stream << command;
    socketStream << msg.size() << msg;

    if (!m_socket->flush()) {
        qDebug() << "failed to flush socket";
        return false;
    }

    return true;
}

bool Client::send(int command, const QByteArray &data)
{
    if (!checkConnection()) return false;

    QByteArray msg;
    QDataStream stream(&msg, QIODevice::WriteOnly);
    QDataStream socketStream(m_socket);
    stream << command << data;
    socketStream << msg.size() << msg;

    if (!m_socket->flush()) {
        qDebug() << "failed to flush socket";
        return false;
    }

    return true;
}

int Client::readCommand(QDataStream &stream)
{
    int command = 0;
    stream >> command;

    return command;
}

QTcpSocket *Client::getSocket() const
{
    return m_socket;
}

void Client::read()
{
    qDebug() << Q_FUNC_INFO;
    QDataStream another(m_socket);

    if ((m_socket->bytesAvailable() >= sizeof(int)) && m_packageSize == -1) {
        another >> m_packageSize;
    } else {
        return;
    }

    if (m_socket->bytesAvailable() < m_packageSize) {
        return;
    }

    QByteArray array;
    another >> array;

    m_packageSize = -1;

    handleData(array);
}

void Client::handleData(const QByteArray& arr)
{
    QDataStream stream(arr);
    int command = readCommand(stream);

    switch (command) {
    case Protocol::Server::SV_LOGIN: {
        User::instance()->deserialize(stream);
        qDebug() << User::instance();
        emit loginSuccessful();
        break;
    }
    case Protocol::Errors::SV_LOGIN_ERR: {
        Message msg;
        stream >> msg;
        emit loginFailed(msg.text);
        break;
    }
    case Protocol::Server::SV_REGISTER: {
        //TODO change
        bool success;
        stream >> success;
        if (success) {
            emit registrationSuccessful();
        } else {
            emit registrationFailed();
        }
        break;
    }
    case Protocol::Errors::SV_REGISTRATION_ERR: {
        //TODO
        break;
    }
    case Protocol::Server::SV_JOINED_SUCCESSFULLY: {
        //TODO
        QByteArray arr;
        QDataStream stream(arr);
        stream >> arr;
        auto room = Room::deserialize(arr);

        if (room.id() == -1) {
            qDebug() << "failed to join";
        }

        emit joinedSuccessfully(room);
        break;
    }
    case Protocol::Server::SV_ROOM_UPDATED: {
        //barr roomData

        break;
    }
    default: {
        qDebug() << "weird command " << command;
        return;
    }
    }
}

bool Client::checkConnection()
{
    if (m_socket->state() != QTcpSocket::ConnectedState) {
        qDebug() << "socket not connected";

        return false;
    }

    return true;
}

