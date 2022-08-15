import QtQuick 2.0
import QtQuick.Controls 2.0
import Globals 1.0

Button {
    id: root

    property alias btnText: text

    background: Rectangle {
        anchors.fill: parent
        color: Globals.topBarColor

        Text {
            id: text

            color: "white"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }
}
