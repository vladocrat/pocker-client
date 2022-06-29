#include "room.h"

Room::Room()
{

}

Room::Room(const Room &)
{
    //TODO needed?
}

QString Room::name() const
{
    return m_name;
}

Room::Status Room::status() const
{
    return m_status;
}

int Room::playerCount() const
{
    return m_playerCount;
}

void Room::setName(const QString& name)
{
    if (name != m_name) {
        m_name = name;
        emit nameChanged();
    }
}

void Room::setStatus(Status status)
{
    if (m_status != status) {
        m_status = status;
        emit statusChanged();
    }
}

void Room::setPlayerCount(int playerCount)
{
    if (m_playerCount != playerCount) {
        m_playerCount = playerCount;
        emit playerCountChanged();
    }
}
