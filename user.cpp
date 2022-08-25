#include "user.h"

void User::deserialize(QDataStream &stream)
{
    QByteArray main;
    QString name;
    QString email;
    QString pfpLink;
    stream >> main;

    QDataStream mainStream(main);
    mainStream >> name >> email >> pfpLink;

    setName(name);
    setEmail(email);
    setPfpLink(pfpLink);
}

void User::setPfpLink(const QString& pfpLink)
{
    m_pfpLink = pfpLink;
    emit pfpLinkChanged();
}

void User::setName(const QString& name)
{
    m_name = name;
    emit nameChanged();
}

void User::setEmail(const QString& email)
{
    m_email = email;
    emit emailChanged();
}

QString User::pfpLink() const
{
    return m_pfpLink;
}

QString User::name() const
{
    return m_name;
}

QString User::email() const
{
    return m_email;
}

