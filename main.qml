import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import Client 1.0
import Globals 1.0
import Page 1.0

Window {
    id: root

    property int resizeBarWidth: 5 //TODO rename

    width: 840
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint

    MouseArea {
        id: dragArea

        property real lastMouseX: 0
        property real lastMouseY: 0

        width: windowToolBar.width - controlBtns.width
        height: windowToolBar.height - root.resizeBarWidth
        anchors.bottom: windowToolBar.bottom

        //TODO if fullscreen, shrink the window (look at windows impl)
        onPressed: {
            dragArea.lastMouseX = dragArea.mouseX
            dragArea.lastMouseY = dragArea.mouseY
        }

        onMouseXChanged: {
            root.x += (dragArea.mouseX - dragArea.lastMouseX)
        }

        onMouseYChanged: {
            root.y += (dragArea.mouseY - dragArea.lastMouseY)
        }
    }

    Rectangle {
        id: windowToolBar

        height: 20
        width: root.width
        color: Globals.topBarColor

        Text {
            text: "pocker"
            color: Globals.whiteToneColor
            font.family: Globals.fontFamily
            anchors.horizontalCenter: windowToolBar.horizontalCenter
        }

        RowLayout {
            id: controlBtns

            width: windowToolBar.width / 5
            height: windowToolBar.height
            spacing: 0
            anchors.right: windowToolBar.right

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            TopBarButton {
                Layout.preferredWidth: 40
                Layout.preferredHeight: controlBtns.height
                btnText {
                    text: "-"
                    font {
                        pointSize: 17
                        bold: true
                    }
                }

                onClicked: {
                    root.showMinimized();
                }
            }

            TopBarButton {
                Layout.preferredWidth: 40
                Layout.preferredHeight: controlBtns.height
                btnText {
                    text: root.Maximized ? "🗗" : "🗖"
                    color: Globals.whiteToneColor
                }

                onClicked: {
                    root.showMaximized();
                }
            }

            TopBarButton {
                Layout.preferredWidth: 40
                Layout.preferredHeight: controlBtns.height
                btnText {
                    color: Globals.whiteToneColor
                    text: "🗙"
                }

                onClicked: {
                    root.close();
                }
            }
        }
    }

    RowLayout {
        width: root.width
        height: windowToolBar.height / 8

        MouseArea {
            Layout.fillHeight: true
            Layout.preferredWidth: root.resizeBarWidth
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
            Layout.preferredWidth: root.resizeBarWidth
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


