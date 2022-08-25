#ifndef USER_H
#define USER_H

#include <QString>
#include <QDataStream>
#include <QObject>
#include <QQmlEngine>

class User : public QObject
{
    Q_OBJECT
public:
    static User* instance() {
        static User user;
        return &user;
    }

    Q_PROPERTY(QString pfpLink READ pfpLink WRITE setPfpLink NOTIFY pfpLinkChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)

    void deserialize(QDataStream& stream);

    QString pfpLink() const;
    QString name() const;
    QString email() const;
    void setPfpLink(const QString&);
    void setName(const QString&);
    void setEmail(const QString&);

    static void registerType() {
       qmlRegisterSingletonInstance<User>("User", 1, 0, "User", User::instance());
    }

signals:
    void pfpLinkChanged();
    void nameChanged();
    void emailChanged();

private:
    User() {};
    ~User() {};
    User(const User&) = delete;
    User(User&&) = delete;
    User& operator=(const User&) = delete;

    QString m_pfpLink;
    QString m_name;
    QString m_passwordHash;
    QString m_email;
};

#endif // USER_H
