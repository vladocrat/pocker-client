import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: root

    signal clicked();

    property string text: ""

    color: "transparent"

    Text {
        anchors.centerIn: parent
        text: root.text
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.clicked();
        }

        onPressed: {
            root.color = "#8c9c98";
        }

        onReleased: {
            if (mouseArea.containsMouse) {
                mouseArea.cursorShape = Qt.PointingHandCursor;
                root.color = "#b9c7c4";
            } else {
                root.color = "transparent";
            }
        }

        onHoveredChanged:  {
            if (mouseArea.containsMouse) {
                mouseArea.cursorShape = Qt.PointingHandCursor;
                root.color = "#b9c7c4";
            } else {
                root.color = "transparent";
            }
        }
    }
}
