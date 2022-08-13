import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import Client 1.0
import Page 1.0

ApplicationWindow {
    id: root

    property int bw: 5

    width: 840
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint
    title: qsTr("pocker")

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = root.bw + 10; // Increase the corner size slightly
            if (p.x < b && p.y < b) return Qt.SizeFDiagCursor;
            if (p.x >= root.width - b && p.y >= height - b) return Qt.SizeFDiagCursor;
            if (p.x >= root.width - b && p.y < b) return Qt.SizeBDiagCursor;
            if (p.x < b && p.y >= root.height - b) return Qt.SizeBDiagCursor;
            if (p.x < b || p.x >= root.width - b) return Qt.SizeHorCursor;
            if (p.y < b || p.y >= root.height - b) return Qt.SizeVerCursor;
        }
        acceptedButtons: Qt.NoButton // don't handle actual events
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
                             const p = resizeHandler.centroid.position;
                             const b = root.bw + 10; // Increase the corner size slightly
                             let e = 0;
                             if (p.x < b) { e |= Qt.LeftEdge }
                             if (p.x >= root.width - b) { e |= Qt.RightEdge }
                             if (p.y < b) { e |= Qt.TopEdge }
                             if (p.y >= root.height - b) { e |= Qt.BottomEdge }
                             root.startSystemResize(e);
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
        anchors.fill: parent

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


