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

        Item {
            width: 20
            height: 20
        }

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
                form.open();
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
