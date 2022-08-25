import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import User 1.0
import Client 1.0
import Globals 1.0
import Utils 1.0

Rectangle {
    id: root

    //TODO add statistics i.e. wins loses total spent total won.
    property alias pic: img
    property string textColor: Globals.whiteToneColor

    color: "transparent"

    ColumnLayout {
        anchors {
            fill: parent
            topMargin: 10
        }

        ProfileImage {
            id: img

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            source: "qrc:/images/arrows.png"
        }

        Text {
            id: username

            Layout.alignment: Qt.AlignHCenter
            text: "Username: " + User.name
            color: root.textColor
            font {
                family: Globals.fontFamily
                pointSize: 10
            }
        }

        Text {
            id: email

            Layout.alignment: Qt.AlignHCenter
            text: "email: " + User.email
            color: root.textColor
            font {
                family: Globals.fontFamily
                pointSize: 10
            }
        }

        Item {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}


