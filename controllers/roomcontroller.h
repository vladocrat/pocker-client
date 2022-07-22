#ifndef ROOMCONTROLLER_H
#define ROOMCONTROLLER_H

#include <QObject>
#include <QQmlEngine>

class RoomController : public QObject
{
    Q_OBJECT
public:
    static RoomController* instance()
    {
        static RoomController rc;
        return &rc;
    }

    Q_INVOKABLE void joinRoom(int);

    static void registerType()
    {
        qmlRegisterSingletonInstance<RoomController>("RoomController", 1, 0, "RoomController", RoomController::instance());
    }

private:
    RoomController() {};
    ~RoomController() {};
    RoomController(const RoomController&) = delete;
    RoomController(RoomController&&) = delete;
    RoomController& operator=(const RoomController&) = delete;
};

#endif // ROOMCONTROLLER_H
