#ifndef PAGES_H
#define PAGES_H

#include <QObject>
#include <QQmlEngine>

class Page
{
 Q_GADGET
public:
    enum Pages {
        LoginPage = 0,
        ProfilePage,
        RegistrationPage,
        RoomListingPage,
        GamePage
    };
    Q_ENUM(Pages);

    static void registerType()
    {
        qmlRegisterUncreatableType<Page>("Page", 1, 0, "Pages", "cant create enum instance");
    }

private:
    Page();
};

#endif // PAGES_H
