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
        id: mainRow

        property real buttonHeight: root.height - 5
        property real buttonWidth: 65

        anchors.fill: parent

        BurgerButton {
            id: bb

            Layout.preferredWidth: 30
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignCenter

            onClicked: {
                root.burgerButtonClicked();
            }
        }

        Item {
            Layout.preferredWidth: mainRow.buttonWidth - 6
            Layout.preferredHeight: mainRow.buttonHeight
        }

        CustomButton {
            Layout.preferredWidth: mainRow.buttonWidth
            Layout.preferredHeight: mainRow.buttonHeight
            text: "login"

            onClicked: {
                root.loginClicked();
            }
        }

        CustomButton {
            Layout.preferredWidth: mainRow.buttonWidth
            Layout.preferredHeight: mainRow.buttonHeight
            text: "add room"

            onClicked: {
                form.open();
            }
        }

        CustomButton {
            Layout.preferredWidth: mainRow.buttonWidth
            Layout.preferredHeight: mainRow.buttonHeight
            text: "registration"

            onClicked: {
                root.registrationClicked();
            }
        }

        CustomButton {
            Layout.preferredWidth: mainRow.buttonWidth
            Layout.preferredHeight: mainRow.buttonHeight
            text: "profile"

            onClicked: {
                root.profileClicked();
            }
        }
    }
}
