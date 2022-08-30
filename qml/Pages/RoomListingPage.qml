import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import Client 1.0
import Globals 1.0

Page {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();
    signal joinedRoom(var room);

    header: TopBar {
        id: topBar

        width: root.width
        height: 40

        onLoginClicked: {
            root.loginClicked();
        }

        onRegistrationClicked: {
            root.registrationClicked();
        }

        onProfileClicked: {
            root.profileClicked();
        }

        onBurgerButtonClicked: {
            if (topBar.burgerButton.state === "open") {
                topBar.burgerButton.state = "closed";
                profileInfo.visible = false;
                return;
            }

            topBar.burgerButton.state= "open";
            profileInfo.visible = true;
        }
    }

    Connections {
        target: Client

        function onJoinedSuccessfully(room) {
            root.joinedRoom(room);
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Globals.themeColor
    }

    RowLayout {
        spacing: 0
        anchors.fill: parent

        ProfilePage {
            id: profileInfo

            Layout.fillHeight: true
            Layout.preferredWidth: root.width / 4.5
            visible: false
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 1

            Rectangle {
                anchors.fill: parent
                color: Globals.themeColor
                layer {
                    enabled: true
                    effect: DropShadow {
                        horizontalOffset: -25
                        verticalOffset: 0
                        cached: true
                        samples: 35
                        color: "#232738"
                    }
                }
            }

            GridView {
                id: gridView

                anchors.leftMargin: 5
                anchors.fill: parent
                clip: true
                cellWidth: 240
                cellHeight: 120
                ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }
                model: roomModel
                delegate: RoomScreenDelegate {
                    width: gridView.cellWidth - 10
                    height: gridView.cellHeight - 10
                    roomIndex: index
                    roomName: model.name
                    roomStatus: model.status
                    roomAccess: model.access
                    roomPlayerCount: model.playerCount
                    roomMaxPlayerCount: model.maxPlayerCount
                    roomInitialBet: model.initialBet
                    radius: 5
                }
            }
        }
    }
}

