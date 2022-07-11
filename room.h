#ifndef ROOM_H
#define ROOM_H

#include <QObject>
#include <QString>

#include "Globals.h"

class Room
{
public:
    Room();
    Room(const Room&);

    enum Status {
        Waiting = 0,
        Playing
    };

    enum Access {
        Public = 0,
        Private
    };

    QString password() const;
    QString name() const;
    Status status() const;
    int playerCount() const;
    Access access() const;
    QString statusString() const;
    QString accessString() const;
    int initialBet() const;
    int maxPlayerCount() const;
    int id() const;
    void setName(const QString&);
    void setStatus(Status);
    void setPlayerCount(int);
    void setAccess(Access);
    void setAccess(int);
    void setInitialBet(int);
    void setId(int);
    void setMaxPlayerCount(int);
    void setPassword(const QString&);

    static Access toAccess(int); //TODO doesn't work properly? check addRoom from controller
    static QByteArray serialize(const Room&);
    static Room deserialize(const QByteArray&);

private:
    int m_id = -1;
    QString m_name = "default";
    Status m_status = Waiting;
    int m_playerCount = 1;
    Access m_access = Public;
    int m_initialBet = Globals::MIN_INITIAL_BET;
    int m_maxPlayerCount = Globals::MIN_PLAYERS;
    QString m_password = "";
};

#endif // ROOM_H
