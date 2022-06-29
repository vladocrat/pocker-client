import QtQuick 2.0

Item {
    id: root

    signal clicked();

    property alias hyperLinkText: hyperlinkText
    property string hoverColor: "#035efc"
    property string color: "blue"

    Text {
        id: hyperlinkText

        text: "link"
        color: root.color
        font.pixelSize: 12
        font.bold: true

        MouseArea{
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onHoveredChanged: {
                //TODO make it one action. too lazy for now
                if (mouseArea.containsMouse) {
                    hyperlinkText.color = root.hoverColor;
                    underline.color = root.hoverColor;
                } else {
                    hyperlinkText.color = root.color;
                    underline.color = root.color;
                }
            }

            onClicked: {
                root.clicked();
            }
        }
    }

    Rectangle{
        id: underline

        width: hyperlinkText.width
        height: 1
        color: root.color
        anchors.top: hyperlinkText.bottom
        anchors.topMargin: -1
    }
}
