import QtQuick 2.0
import QtQuick.Layouts 1.12
import RoomModel 1.0
import Globals 1.0

Rectangle {
    id: root

    property alias burgerButton: bb

    signal loginClicked();
    signal registrationClicked();
    signal profileClicked();
    signal burgerButtonClicked();

    color: Globals.mainColor
    border.width: 1

    RowLayout {
        anchors.fill: parent

        BurgerButton {
            id: bb

            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24

            onClicked: {
                root.burgerButtonClicked();
            }
        }

        Item {
           Layout.preferredWidth: 20
           Layout.preferredHeight: 24
        }

        HyperLink {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 24
            hyperLinkText.text: "login"

            onClicked: {
                root.loginClicked();
            }
        }

        HyperLink {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 24
            hyperLinkText.text: "add room"

            onClicked: {
                form.open();
            }
        }

        HyperLink {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 24
            hyperLinkText.text: "registration"

            onClicked: {
                root.registrationClicked();
            }
        }

        HyperLink {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 24
            hyperLinkText.text: "profile"

            onClicked: {
                root.profileClicked();
            }
        }
    }
}
