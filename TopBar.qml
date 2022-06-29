import QtQuick 2.0
import QtQuick.Layouts 1.12
import RoomModel 1.0

Rectangle {
    id: root

    border.width: 1

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();

    RowLayout {
        anchors.fill: parent

        HyperLink {
            width: 40
            height: 20
            hyperLinkText.text: "login"

            onClicked: {
                root.loginClicked();
            }
        }

        HyperLink {
            width: 40
            height: 20
            hyperLinkText.text: "add room"

            onClicked: {
                RoomModel.addRoom();
            }
        }

        HyperLink {
            width: 40
            height: 20
            hyperLinkText.text: "registration"

            onClicked: {
                root.registrationClicked();
            }
        }

        HyperLink {
            width: 40
            height: 20
            hyperLinkText.text: "profile"

            onClicked: {
                root.profileClicked();
            }
        }
    }
}
