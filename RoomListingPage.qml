import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import Client 1.0

ColumnLayout {
    id: root

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    property int footerSize: 5

    TopBar {
        id: topBar

        Layout.fillWidth: true
        Layout.preferredWidth: root.width
        Layout.preferredHeight: 40

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

    RowLayout {
        ProfilePage {
            id: profileInfo

            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 3
            Layout.bottomMargin: root.footerSize
        }

        GridView {
            id: gridView

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 3
            Layout.bottomMargin: root.footerSize
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

