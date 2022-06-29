import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import RoomModel 1.0

ColumnLayout {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    width: 625
    height: 400
    spacing: 10

    TopBar {
        id: topBar

        width: parent.width
        height: 20
        Layout.alignment: Qt.AlignTop

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

        Layout.alignment: Qt.AlignHCenter
        width: root.width
        height: root.height - topBar.height
        clip: true
        cellWidth: 125
        cellHeight: 100
        ScrollBar.vertical: ScrollBar {}
        model: RoomModel.rooms
        delegate: RoomScreenDelegate {
            width: gridView.cellWidth - 10
            height: gridView.cellHeight - 10
        }
    }
}
