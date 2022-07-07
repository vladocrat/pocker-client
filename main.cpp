#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QJSEngine>
#include <memory>

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

    Client::registerType();
    FieldManager::registerType();
    LoginController::registerType();
    User::registerType();
    Page::registerType();
    RoomModel::registerType();

    qmlRegisterSingletonType(QUrl("qrc:/Globals.qml"), "Globals", 1, 0, "Globals");
    QQmlApplicationEngine engine;

    std::unique_ptr<RoomModel> model = std::make_unique<RoomModel>();
    Room room;
    room.setName("cool name");
    room.setPlayerCount(1);
    room.setStatus(Room::Status::Playing);
    room.setAccess(Room::Access::Public);

    model->addRoom(room);
    model->addRoom(Room());
    model->addRoom(Room());
    model->addRoom(Room());

    engine.rootContext()->setContextProperty("roomModel", model.get());


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
