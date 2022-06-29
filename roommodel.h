#ifndef ROOMMODEL_H
#define ROOMMODEL_H

#include <QObject>
#include <QList>
#include <QQmlEngine>

#include "room.h"

class RoomModel : public QObject
{
    Q_OBJECT
public:

    static RoomModel* instance()
    {
        static RoomModel model;
        return &model;
    }

    Q_PROPERTY(QList<Room*> rooms READ rooms WRITE setRooms NOTIFY roomsChanged)

    QList<Room*> rooms() const;
    void setRooms(const QList<Room*>&);
    Q_INVOKABLE void addRoom();

    static void registerType()
    {
        qmlRegisterSingletonInstance<RoomModel>("RoomModel", 1, 0, "RoomModel", RoomModel::instance());
    }

signals:
    void roomsChanged();

private:
    RoomModel();

    QList<Room*> m_rooms;
};

#endif // ROOMMODEL_H
