#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QJSEngine>
#include <memory>

#include "client.h"
#include "fieldmanager.h"
#include "user.h"
#include "Pages.h"
#include "roommodel.h"
#include "controllers/logincontroller.h"
#include "controllers/modelcontroller.h"
#include "controllers/roomcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Client::registerType();
    FieldManager::registerType();
    User::registerType();
    Page::registerType();
    RoomModel::registerType();

    LoginController::registerType();
    ModelController::registerType();
    RoomController::registerType();

    qmlRegisterSingletonType(QUrl("qrc:/Globals.qml"), "Globals", 1, 0, "Globals");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("roomModel", ModelController::instance()->model());

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
