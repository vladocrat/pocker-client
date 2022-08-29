#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QQmlEngine>

#include "room.h"
#include "LoginData.h"

class Client :  public QObject
{
    Q_OBJECT
public:
    static Client* instance()
    {
        static Client client;
        return &client;
    }

    Q_INVOKABLE void connectHost();
    Q_INVOKABLE bool sendCommand(int command);
    Q_INVOKABLE bool send(int command, const QByteArray& data);

    int readCommand(QDataStream&);
    QTcpSocket* getSocket() const;

    static void registerType() {
        qmlRegisterSingletonInstance<Client>("Client", 1, 0, "Client",
                                             Client::instance());
    }

private slots:
    void read();

signals:
    void registrationSuccessful();
    void registrationFailed(const QString& msg);
    void loginFailed(const QString& msg);
    void loginSuccessful();
    void joinedSuccessfully(const Room& room);

private:
    Client();
    ~Client();
    Client(const Client&) = delete;
    Client(Client&&) = delete;
    Client& operator=(const Client&) = delete;

    void handleData(const QByteArray& arr);
    bool checkConnection();

    const int port = 8082;
    const QString address = "127.0.0.1";
    QTcpSocket* m_socket = nullptr;
    int m_packageSize = -1;
};

#endif // CLIENT_H
