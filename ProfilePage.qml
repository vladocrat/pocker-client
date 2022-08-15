import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import User 1.0
import Client 1.0
import Globals 1.0

Rectangle {
    id: root

    //TODO add statistics i.e. wins loses total spent total won.
    property alias pic: img
    property string textColor: Globals.whiteToneColor

    color: "transparent"
    border.width: 1

    ColumnLayout {
        width: parent.width
        height: parent.height / 2.5

        ProfileImage {
            id: img

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            source: "images/arrows.png"
        }

        Text {
            id: username

            Layout.alignment: Qt.AlignHCenter
            text: "Username: " + User.name
            color: root.textColor
        }

        Text {
            id: email

            Layout.alignment: Qt.AlignHCenter
            text: "email: " + User.email
            color: root.textColor
        }
    }
}

