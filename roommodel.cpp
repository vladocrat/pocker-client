#include "roommodel.h"

#include <algorithm>

#include "client.h"

RoomModel::RoomModel()
{
    connect(Client::instance(), &Client::joinedSuccessfully, this, &RoomModel::updateRoom);
}

void RoomModel::addRoom(const Room& room)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_rooms << room;
    endInsertRows();
}

int RoomModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);

    return m_rooms.count();
}

QVariant RoomModel::data(const QModelIndex& index, int role) const
{
    if (index.row() < 0 || index.row() >= m_rooms.count()) {
        return QVariant();
    }

    auto room = m_rooms[index.row()];
    switch (role){
    case NameRole: {
        return room.name();
    }
    case StatusRole: {
        return room.statusString();
    }
    case PlayerCountRole: {
        return room.playerCount();
    }
    case AccessRole: {
        return room.accessString();
    }
    case InitialBetRole: {
        return room.initialBet();
    }
    case MaxPlayerCountRole: {
        return room.maxPlayerCount();
    }
    default:
        return QVariant();
    }
}

void RoomModel::updateRoom(const Room& newRoom)
{
    auto room = findRoomById(newRoom.id());
    room->setName(newRoom.name());
    room->setStatus(newRoom.status());
    room->setAccess(newRoom.access());
    room->setInitialBet(newRoom.access());
    room->setPlayerCount(newRoom.playerCount());
}

QHash<int, QByteArray> RoomModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[StatusRole] = "status";
    roles[PlayerCountRole] = "playerCount";
    roles[AccessRole] = "access";
    roles[InitialBetRole] = "initialBet";
    roles[MaxPlayerCountRole] = "maxPlayerCount";

    return roles;
}

Room* RoomModel::findRoomById(int id)
{
    auto room = std::find_if(m_rooms.begin(), m_rooms.end(), [id] (const Room& room) {
        return room.id() == id;
    });

    return &room[0];
}
