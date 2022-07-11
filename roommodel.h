#ifndef ROOMMODEL_H
#define ROOMMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QList>
#include <QQmlEngine>

#include "room.h"

class RoomModel : public QAbstractListModel
{
    Q_OBJECT
public:
    RoomModel();

    enum RoomRoles {
        NameRole = Qt::UserRole + 1,
        StatusRole,
        PlayerCountRole,
        AccessStringRole,
        InitialBetRole,
        MaxPlayerCountRole,
    };
    Q_ENUM(RoomRoles);

    void addRoom(const Room&);
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;

    static void registerType()
    {
        qmlRegisterUncreatableType<RoomModel>("RoomModel", 1, 0, "RoomModel", "Cant create instance of RoomModel");
    }

private slots:
    void updateRoom(const Room&);

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    Room* findRoomById(int);

    QList<Room> m_rooms;
};

#endif // ROOMMODEL_H
