#include "modelcontroller.h"

#include "Globals.h"
#include "client.h"
#include "protocol.h"

bool ModelController::createRoom(const QString& name, int maxPlayers, int initialBet, bool access, const QString& password)
{
    if (name == "") {
        qDebug() << "name is empty";

        return false;
    }

    if (maxPlayers < Globals::MIN_PLAYERS || maxPlayers > Globals::MAX_PLAYERS) {
        qDebug() << "incorrect amount of players";

        return false;
    }

    if (initialBet < Globals::MIN_INITIAL_BET || initialBet > Globals::MAX_INITIAL_BET) {
        qDebug() << "incorrect initial bet";

        return false;
    }

    if (Room::toAccess(access) == Room::Private && (password == "" || password.length() != 4)) {
        qDebug() << "access is set to private but no password was provided";

        return false;
    }

    Room room;
    room.setName(name);
    room.setMaxPlayerCount(maxPlayers);
    room.setInitialBet(initialBet);
    room.setAccess(access);

    if (room.access() == Room::Private) {
        room.setPassword(password);
    }

    if (!Client::instance()->send(Protocol::Client::CL_CREATE_ROOM, Room::serialize(room))) {
        qDebug() << "failed to send to the server";

        return false;
    }

    return true;
}

void ModelController::append(const Room& room)
{
    m_model.addRoom(room);
}

RoomModel* ModelController::model()
{
    return &m_model;
}
