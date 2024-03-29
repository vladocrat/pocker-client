#ifndef LOGINCONTROLLER_H
#define LOGINCONTROLLER_H

#include <QObject>
#include <QQmlEngine>
#include <QString>

#include "user.h"

class LoginController : public QObject
{
    Q_OBJECT
public:
    static LoginController* instance()
    {
        static LoginController controller;
        return &controller;
    }

    static void registerType()
    {
        qmlRegisterSingletonInstance<LoginController>("LoginController", 1, 0, "LoginController",
                                                      LoginController::instance());
    }

    Q_INVOKABLE bool login(const QString& login, const QString& password);
    Q_INVOKABLE bool registerUser(const QString& login, const QString& email, const QString& password);

private:
    LoginController() {};
    ~LoginController() {};
    LoginController(const LoginController&) = delete;
    LoginController(LoginController&&) = delete;
    LoginController operator=(const LoginController&) = delete;
};

#endif // LOGINCONTROLLER_H
