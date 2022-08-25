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

    static void registerType()
    {
        qmlRegisterSingletonInstance<ModelController>("ModelController", 1, 0, "ModelController",
                                                      ModelController::instance());
    }

private:
    ModelController() {};
    ~ModelController() {};
    ModelController(const ModelController&) = delete;
    ModelController(ModelController&&) = delete;
    ModelController& operator=(const ModelController&) = delete;

    RoomModel m_model;
};

#endif // MODELCONTROLLER_H
