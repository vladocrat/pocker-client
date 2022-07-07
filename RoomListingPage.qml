import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Client 1.0

ColumnLayout {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    spacing: 10

    TopBar {
        id: topBar

        Layout.preferredHeight: 20
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true

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

    GridView {
        id: gridView

        Layout.fillHeight: true
        Layout.fillWidth: true
        clip: true
        cellWidth: 154
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
            radius: 4
        }
    }
}
