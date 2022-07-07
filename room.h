#ifndef ROOM_H
#define ROOM_H

#include <QObject>
#include <QString>

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

    QString name() const;
    Status status() const;
    int playerCount() const;
    Access access() const;
    QString statusString() const;
    int initialBet() const;
    int id() const;
    void setName(const QString&);
    void setStatus(Status);
    void setPlayerCount(int);
    void setAccess(Access);
    void setInitialBet(int);
    void setId(int);

    static QByteArray serialize(const Room&);
    static Room deserialize(const QByteArray&);

private:
    int m_id = -1;
    QString m_name = "default";
    Status m_status = Waiting;
    int m_playerCount = 0;
    Access m_access = Public;
    int m_initialBet = 0;
};

#endif // ROOM_H
