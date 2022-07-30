import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Client 1.0

ColumnLayout {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    TopBar {
        id: topBar

        Layout.fillWidth: true
        Layout.preferredWidth: root.width
        height: 20

        onLoginClicked: {
            root.loginClicked();
        }

        onRegistrationClicked: {
            root.registrationClicked();
        }

        onProfileClicked: {
            root.profileClicked();
        }
    }

    Row {
        ColumnLayout {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                RowLayout {
                    width: parent.width
                    height: parent.height

                    Item {
                        id: whiteSpaceFiller

                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: ( parent.width * 2) / 3
                    }

                    BurgerButton {
                        id: bb

                        Layout.alignment: Qt.AlignRight
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (bb.state === "menu") {
                            bb.state = "back";
                            whiteSpaceFiller.visible = false;

                            return;
                        }

                        bb.state= "menu";
                        whiteSpaceFiller.visible = true;
                    }
                }
            }

            ProfilePage {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: 3
            }
        }

        GridView {
            id: gridView

            Layout.fillHeight: true
            Layout.fillWidth: true
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

