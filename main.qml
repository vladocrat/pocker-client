import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import Client 1.0
import Globals 1.0
import Page 1.0

ApplicationWindow {
    id: root

    property int topLeftResizeBarWidth: 5 //TODO rename

    width: 840
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint

    Rectangle {
        id: windowToolBar

        height: 15
        width: root.width
        color: Globals.topBarColor

        Text {
            text: "pocker"
            color: "white"
            font.family: Globals.fontFamily
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RowLayout {
        width: root.width
        height: windowToolBar.height

        MouseArea {
            Layout.fillHeight: true
            Layout.preferredWidth: root.topLeftResizeBarWidth
            cursorShape: Qt.SizeFDiagCursor

            onPressed: {
                root.startSystemResize(Qt.LeftEdge | Qt.TopEdge);
            }
        }

        MouseArea {
            Layout.fillHeight: true
            Layout.fillWidth: true
            cursorShape: Qt.SizeVerCursor

            onPressed: {
                root.startSystemResize(Qt.TopEdge);
            }
        }

        MouseArea {
            Layout.fillHeight: true
            Layout.preferredWidth: root.topLeftResizeBarWidth
            cursorShape: Qt.SizeBDiagCursor

            onPressed: {
                root.startSystemResize(Qt.RightEdge | Qt.TopEdge);
            }
        }
    }

    RoomCreationForm {
        id: form

        x: Math.round((root.width - form.width) / 2)
        y: Math.round((root.height - form.height) / 2)
        width: 270
        height: 350
    }

    Item {
        id: item

        anchors.top: windowToolBar.bottom
        width: root.width
        height: root.height - windowToolBar.height

        StackLayout {
            id: layout

            currentIndex: Pages.RoomListingPage
            anchors.fill: parent

            LoginPage {
                Layout.alignment: Qt.AlignCenter

                onLoginSuccessful: {
                    layout.currentIndex = Pages.RoomListingPage;
                }

                onLoginFailed: {
                    err.text = msg;
                    layout.currentIndex = 3;// show err
                }

                onRegistrationRequired:  {
                    layout.currentIndex = Pages.RegistrationPage;
                }
            }

            ProfilePage {
                Layout.alignment: Qt.AlignCenter
            }

            RegistrationPage {
                Layout.alignment: Qt.AlignCenter

                onRegistrationSucessful: {
                    layout.currentIndex = Pages.LoginPage;
                }

                onRegistrationFailed: {
                    err.text = msg;
                    layout.currentIndex = 3;// show err
                }

                onLoginRequired: {
                    layout.currentIndex = Pages.LoginPage;
                }
            }

            RoomListingPage {
                Layout.fillHeight: true
                Layout.fillWidth: true

                onLoginClicked: {
                    layout.currentIndex = Pages.LoginPage;
                }
            }

            Text {
                id: err

                color: "red"
                font.pointSize: 20
                text: "error"
            }
        }
    }
}


