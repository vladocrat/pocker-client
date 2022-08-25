import QtQuick 2.0
import QtQuick.Controls 2.1
import Globals 1.0

Rectangle {
    id: root

    signal clicked();

    property string text: "button"
    property alias mouseArea: mouseArea
    property string hoverColor: "#ecd4dc"
    property string pressColor: "#ed4771"
    property string textColor: "#6c1e37"
    property string defaultColor: "white"
    property int cursorShape: Qt.PointingHandCursor
    property string iconSource: ""

    radius: 4
    border.width: 2
    width: 20
    height: 20

    Text {
        id: btnText

        text: root.text
        color: root.textColor
        font {
            pointSize: 10
            family: Globals.fontFamily
            bold: true
        }
        anchors {
            verticalCenter: root.verticalCenter
            left: root.left
            leftMargin: root.iconSource === "" ? root.width / 4 : root.width / 3
        }
    }

    Image {
        id: icon

        height: 25
        width: 25
        source: root.iconSource
        fillMode: Image.PreserveAspectFit
        anchors {
            verticalCenter: root.verticalCenter
            left: btnText.right
            leftMargin: 7
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: root
        hoverEnabled: true
        cursorShape: root.cursorShape

        onHoveredChanged: {
            if (mouseArea.containsMouse) {
                root.color = root.hoverColor;
            } else {
                root.color = root.defaultColor;
            }
        }

        onClicked: {
            root.clicked();
        }

        onReleased: {
            root.color = mouseArea.containsMouse ? root.hoverColor : root.defaultColor
        }
    }
}
