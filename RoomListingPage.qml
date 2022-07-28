import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Client 1.0

Item {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    TopBar {
        id: topBar

        anchors.top: root.top
        width: root.width
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

    RowLayout {
        spacing: 50

        anchors{
            top: topBar.bottom
            right: root.right
            left: root.left
            bottom: root.bottom
            topMargin: 10
        }

        ProfilePage {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 2
            Layout.alignment: Qt.AlignTop
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
