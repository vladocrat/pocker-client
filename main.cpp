#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QJSEngine>

#include "client.h"
#include "fieldmanager.h"
#include "logincontroller.h"
#include "user.h"
#include "Pages.h"
#include "roommodel.h"
#include "room.h"
#include "../common/protocol.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Client::registerType();
    FieldManager::registerType();
    LoginController::registerType();
    User::registerType();
    Page::registerType();
    RoomModel::registerType();

    QList<Room*> rooms;
    rooms.append(new Room);
    rooms.append(new Room);
    rooms.append(new Room);
    rooms.append(new Room);
    RoomModel::instance()->setRooms(rooms);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    qDebug() << "client started";
    return app.exec();
}
