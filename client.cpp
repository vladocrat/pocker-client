#include <QDataStream>
#include <QtCore>
#include <QDebug>
#include <cassert>
#include <QVector>

#include "client.h"
#include "user.h"
#include "room.h"
#include "controllers/modelcontroller.h"
#include "protocol.h"
#include "Message.h" 
#include "integer.h"

namespace Internal
{
QString readMsg(QDataStream& stream)
{
    Message msg;
    stream >> msg;

    return msg.text;
}
}

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

    if (!m_socket->waitForConnected(1000)) {
        qDebug() << "time for connection exceeded";
    }
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

bool Client::send(int command, const QByteArray& data)
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

int Client::readCommand(QDataStream& stream)
{
    int command = 0;
    stream >> command;

    return command;
}

QTcpSocket* Client::getSocket() const
{
    return m_socket;
}

void Client::read()
{
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
        sendCommand(Protocol::Client::CL_REQUEST_ROOMS);
        emit loginSuccessful();
        break;
    }
    case Protocol::Errors::SV_LOGIN_ERR: {
        emit loginFailed(Internal::readMsg(stream));
        break;
    }
    case Protocol::Server::SV_REGISTER: {
        emit registrationSuccessful();
    }
    case Protocol::Errors::SV_REGISTRATION_ERR: {
        emit registrationFailed(Internal::readMsg(stream));
        break;
    }
    case Protocol::Server::SV_JOINED_SUCCESSFULLY: {
        QByteArray roomData;
        stream >> roomData;
        auto room = Room::deserialise(roomData);

        if (room.id() == -1) {
            qDebug() << "Failed to join";

            return;
        }

        emit joinedSuccessfully(room);
        break;
    }
    case Protocol::Server::SV_ROOM_UPDATED: {
        //barr roomData

        break;
    }
    case Protocol::Server::SV_ROOM_CREATED: {
        QByteArray roomData;
        stream >> roomData;
        auto room = Room::deserialise(roomData);
        ModelController::instance()->append(room);
        Integer id {room.id()};

        if (!send(Protocol::Client::CL_ROOM_CHOICE, id.serialise())) {
            qDebug() << "Failed to send request";
        }

        break;
    }
    case Protocol::Errors::SV_FAILED_TO_CREATE_ROOM: {
        emit roomCreationFailed("Failed to create room");
        break;
    }
    case Protocol::Server::SV_LIST_OF_ROOMS: {
        QByteArray baRooms;
        stream >> baRooms;
        QDataStream readRooms(baRooms);
        QVector<QByteArray> rooms;
        int amountOfRooms = 0;
        readRooms >> amountOfRooms;

        for (int i = 0; i < amountOfRooms; i++) {
            QByteArray arr;
            readRooms >> arr;
            rooms.append(arr);
        }

        for (const auto& room : rooms) {
            ModelController::instance()->append(Room::deserialise(room));
        }

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
        connectHost();

        if (m_socket->state() == QTcpSocket::ConnectedState) {
            return true;
        }

        qDebug() << "socket not connected";

        return false;
    }

    return true;
}

