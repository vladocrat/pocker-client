#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
#include <QQmlEngine>

#include "roommodel.h"
#include "room.h"

class ModelController : public QObject
{
    Q_OBJECT
public:
    static ModelController* instance()
    {
        static ModelController mc;
        return &mc;
    }

    Q_INVOKABLE bool createRoom(const QString& name, int maxPlayers, int initialBet, int access, const QString& password = "");
    Q_INVOKABLE void append(const Room& room);
    RoomModel* model();

    //TODO operator<<
    static void registerType()
    {
        qmlRegisterSingletonInstance<ModelController>("ModelController", 1, 0, "ModelController",
                                                      ModelController::instance());
    }

private:
    ModelController()
    {
        Room room;
        room.setName("cool name");
        room.setPlayerCount(1);
        room.setStatus(Room::Status::Playing);
        room.setAccess(Room::Access::Public);

        m_model.addRoom(room);
        m_model.addRoom(Room());
        m_model.addRoom(Room());
        m_model.addRoom(Room());
    }
    ~ModelController() {};
    ModelController(const ModelController&) = delete;
    ModelController(ModelController&&) = delete;
    ModelController& operator=(const ModelController&) = delete;

    RoomModel m_model;
};

#endif // MODELCONTROLLER_H
