import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import Client 1.0
import Globals 1.0
import Page 1.0

Window {
    id: root

    property int resizeBarWidth: 5

    width: 840
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint | Qt.Window


    Rectangle {
        id: windowToolBar

        height: 25
        width: root.width
        color: Globals.topBarColor

        Text {
            text: "pocker"
            color: Globals.whiteToneColor
            anchors.centerIn: windowToolBar
            font {
                family: Globals.fontFamily
                bold: true
            }
        }

        RowLayout {
            id: controlBtns

            property int buttonsWidth: 40

            width: windowToolBar.width / 5
            height: windowToolBar.height
            spacing: 0
            anchors {
                right: windowToolBar.right
                rightMargin: root.resizeBarWidth
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            TopBarButton {
                id: minimizeBtn

                Layout.preferredWidth: controlBtns.buttonsWidth
                Layout.preferredHeight: controlBtns.height
                hoverEnabled: true
                btnText {
                    text: "-"
                    font {
                        pointSize: 17
                        bold: true
                    }
                }

                onHoveredChanged: {
                    if (minimizeBtn.hovered) {
                        btnText.color = Globals.whiteHoverColor
                    } else {
                        btnText.color = Globals.whiteToneColor
                    }
                }

                onClicked: {
                    root.showMinimized();
                }
            }

            TopBarButton {
                id: maximizeBtn

                Layout.preferredWidth: controlBtns.buttonsWidth
                Layout.preferredHeight: controlBtns.height
                hoverEnabled: true
                btnText {
                    //TODO create enum with window states.
                    text: root.Maximized ? "🗗" : "🗖"
                    color: Globals.whiteToneColor
                }

                onHoveredChanged: {
                    if (maximizeBtn.hovered) {
                        btnText.color = Globals.whiteHoverColor
                    } else {
                        btnText.color = Globals.whiteToneColor
                    }
                }

                onClicked: {
                    root.showMaximized();
                }
            }

            TopBarButton {
                id: closeBtn

                Layout.preferredWidth: controlBtns.buttonsWidth
                Layout.preferredHeight: controlBtns.height
                hoverEnabled: true
                btnText {
                    color: Globals.whiteToneColor
                    text: "🗙"
                }

                onHoveredChanged: {
                    if (closeBtn.hovered) {
                        btnText.color = "red"
                    } else {
                        btnText.color = Globals.whiteToneColor
                    }
                }

                onClicked: {
                    root.close();
                }
            }
        }
    }

    MouseArea {
        id: dragArea

        width: windowToolBar.width - controlBtns.width
        height: windowToolBar.height - root.resizeBarWidth
        anchors.bottom: windowToolBar.bottom

        //TODO if fullscreen, shrink the window (look at windows impl)
        onPressed: {
            root.startSystemMove();
        }
    }

    RowLayout {
        id: resizeArea

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
                    layout.currentIndex = 3;//TODO show err
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
                    layout.currentIndex = 3;//TODO show err
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
