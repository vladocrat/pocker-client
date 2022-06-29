#ifndef ROOM_H
#define ROOM_H

#include <QObject>
#include <QString>

class Room : public QObject
{
    Q_OBJECT
public:
    Room();
    Room(const Room&);

    enum Status {
        Waiting,
        Playing
    };
    Q_ENUM(Status)

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(Status status READ status WRITE setStatus NOTIFY statusChanged)
    Q_PROPERTY(int playerCount READ playerCount WRITE setPlayerCount NOTIFY playerCountChanged)

    QString name() const;
    Status status() const;
    int playerCount() const;
    void setName(const QString&);
    void setStatus(Status);
    void setPlayerCount(int);

signals:
    void nameChanged();
    void statusChanged();
    void playerCountChanged();

private:
    QString m_name;
    Status m_status;
    int m_playerCount;
    const int m_maxPlayers = 4;
};

#endif // ROOM_H
