#include "logincontroller.h"

#include <QDataStream>
#include <QByteArray>

#include "client.h"
#include "RegisterData.h"
#include "protocol.h"
#include "LoginData.h"

namespace Internal
{
//TODO CLIENT SHOULD DO THE SEDNING;
    bool sendData(int command, const LoginData& data)
    {
        auto socket = Client::instance()->getSocket();
        QByteArray msg;
        QDataStream stream(&msg, QIODevice::WriteOnly);
        QDataStream socketStream(socket);

        if (socket->state() == QTcpSocket::ConnectedState) {
            stream << command;
            stream << data;
            socketStream << msg.size() << msg;
            socket->flush();

            return true;
        } else {
            Client::instance()->connectHost();
        }

        qDebug() << "socket not connected";

        return false;
    }

    bool sendData(int command, const RegisterData& data)
    {
        auto socket = Client::instance()->getSocket();
        QByteArray msg;
        QDataStream stream(&msg, QIODevice::WriteOnly);
        QDataStream socketStream(socket);

        if (socket->state() == QTcpSocket::ConnectedState) {
            stream << command;
            stream << data;
            socketStream << msg.size() << msg;
            socket->flush();

            return true;
        }
        qDebug() << "socket not connected";

        return false;
    }
}

bool LoginController::login(const QString& login, const QString& password)
{
    LoginData data {login, password};
    return Internal::sendData(Protocol::Client::CL_LOGIN, data);
}

bool LoginController::registerUser(const QString &login, const QString &email, const QString &password)
{
    RegisterData data;
    data.login = login;
    data.password = password;
    data.email = email;
    return Internal::sendData(Protocol::Client::CL_REGISTER, data);
}




