#include "logincontroller.h"

#include <QDataStream>
#include <QByteArray>

#include "client.h"
#include "RegisterData.h"
#include "protocol.h"
#include "LoginData.h"

bool LoginController::login(const QString& login, const QString& password)
{
    LoginData data {login, password};
    return Client::instance()->send(Protocol::Client::CL_LOGIN, data.serialise());
}

bool LoginController::registerUser(const QString &login, const QString &email, const QString &password)
{
    RegisterData data;
    data.login = login;
    data.password = password;
    data.email = email;
    return Client::instance()->send(Protocol::Client::CL_REGISTER, data.serialise());
}
