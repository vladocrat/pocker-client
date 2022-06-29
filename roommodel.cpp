#include "roommodel.h"

RoomModel::RoomModel()
{

}

QList<Room*> RoomModel::rooms() const
{
    return m_rooms;
}

void RoomModel::setRooms(const QList<Room*>& rooms)
{
    m_rooms = rooms;
}

void RoomModel::addRoom()
{
    auto room = new Room;
    m_rooms.append(room);
    emit roomsChanged();
}
