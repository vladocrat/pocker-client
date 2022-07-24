QT += quick network

INCLUDEPATH += "..\\client\\" \
               ..\\client\\pocker-common\\ \

SOURCES += \
        controllers\\*.cpp \
        client.cpp \
        fieldmanager.cpp \
        main.cpp \
        roommodel.cpp \
        user.cpp \
        pocker-common\\sources\\*.cpp \

HEADERS += \
    controllers\\*.h \
    pocker-common\\headers\\*.h \
    Pages.h \
    client.h \
    fieldmanager.h \
    roommodel.h \
    user.h \

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



