#include "roomcontroller.h"

#include "client.h"
#include "protocol.h"
#include "integer.h"

void RoomController::joinRoom(int roomId)
{   
    Integer i(roomId);

    if (!Client::instance()->send(Protocol::Client::CL_ROOM_CHOICE, i.serialise())) {
        qDebug() << "failed to send";
    }
}
