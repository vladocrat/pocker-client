import QtQuick 2.0
import QtQuick.Layouts 1.12
import RoomModel 1.0
import Client 1.0

Rectangle {
    id: root

    border.width: 1
    radius: 4

    Item {
       id: internal

       property int leftMargin: 3
    }

    ColumnLayout {

        anchors.fill: parent

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Name"
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Status: "
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Players: "
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            Client.send(18, 0);
        }
    }
}
