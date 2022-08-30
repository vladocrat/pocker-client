import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Room 1.0

Page {
    id: root

    property alias room: room

    ColumnLayout {
        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 3
            topMargin: 3
        }

        Text {
            text: "id: " + room.id
        }

        Text {
            text: "name: " + room.name
        }

        Text {
            text: "password: " + room.password
        }

        Text {
            text: "initialBet: " + room.initialBet
        }

        Text {
            text: "playerCount: " + room.playerCount
        }

        Text {
            text: "maxPlayerCount: " + room.maxPlayerCount
        }

        Text {
            text: "access: " + room.access
        }

        Text {
            text: "status: " + room.status
        }
    }

    Rectangle {
        anchors.centerIn: parent
        width: root.width / 1.5
        height: root.height / 1.5
        border.width: 1
    }

    Room {
        id: room
    }
}
