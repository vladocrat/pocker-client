#include "room.h"

#include <QDataStream>

Room::Room()
{

}

Room::Room(const Room& other)
{
    m_name = other.name();
    m_status = other.status();
    m_playerCount = other.playerCount();
    m_access = other.access();
}

QString Room::name() const
{
    return m_name;
}

Room::Status Room::status() const
{
    return m_status;
}

QString Room::statusString() const
{
    switch (m_status) {
    case Status::Playing: {
        return "Playing";
    }
    case Status::Waiting: {
        return "Waiting";
    }
    default:
        return "undefined";
    }
}

int Room::initialBet() const
{
    return m_initialBet;
}

int Room::id() const
{
    return m_id;
}

int Room::playerCount() const
{
    return m_playerCount;
}

Room::Access Room::access() const
{
    return m_access;
}

void Room::setAccess(Access access)
{
    m_access = access;
}

void Room::setInitialBet(int bet)
{
    m_initialBet = bet;
}

void Room::setId(int id)
{
    m_id = id;
}

QByteArray Room::serialize(const Room& room)
{
    QByteArray arr;
    QDataStream stream(arr);
    stream << room.id()
           << room.name()
           << room.status()
           << room.playerCount()
           << room.access()
           << room.initialBet();

    return arr;
}

Room Room::deserialize(const QByteArray& arr)
{
    QDataStream stream(arr);
    Room room;
    stream >> room.m_id
            >> room.m_name
            >> room.m_status
            >> room.m_playerCount
            >> room.m_status
            >> room.m_initialBet;

    return room;
}

void Room::setName(const QString& name)
{
    if (name != m_name) {
        m_name = name;
    }
}

void Room::setStatus(Status status)
{
    if (m_status != status) {
        m_status = status;
    }
}

void Room::setPlayerCount(int playerCount)
{
    if (m_playerCount != playerCount) {
        m_playerCount = playerCount;
    }
}
