import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    id: root

    readonly property bool on: rightSide.enabled

    Rectangle {
        id: leftSide

        width: root.width / 2
        height: root.height
        anchors.left: root.left
        color: leftSide.enabled ? "#0be30b" : "#65ba65"
        enabled: !rightSide.enabled

        Text {
            text: "Public"
            color: "black"
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                leftSide.enabled = false;
                rightSide.enabled = true;
            }
        }
    }

    Rectangle {
        id: rightSide

        width: root.width / 2
        height: root.height
        anchors.right: root.right
        color: rightSide.enabled ? "#e30b0b" : "#bd5959"
        enabled: !leftSide.enabled

        Text {
            text: "Private"
            color: "black"
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                rightSide.enabled = false;
                leftSide.enabled = true;
            }
        }
    }
}
