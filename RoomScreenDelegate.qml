import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import RoomModel 1.0
import Client 1.0

Rectangle {
    id: root

    property int roomIndex: -100
    property string roomName: "default"
    property string roomStatus: "default"
    property int roomPlayerCount: 0
    property int roomAccess: 0

    border.width: 1
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 7
        verticalOffset: 12
    }

    Item {
        id: internal

        property int leftMargin: 3
        property int secondScreenAnimDuration: 50
        property int firstScreenAnimDuration: 0
    }

    StackView {
        id: stack

        anchors.fill: parent
        initialItem: firstScreen

        pushEnter: Transition {
            ParallelAnimation  {
                PropertyAnimation {
                    target: firstScreen
                    property: "height"
                    from: firstScreen.height
                    to: 0
                    duration: internal.firstScreenAnimDuration
                }

                PropertyAnimation {
                    target: secondScreen
                    property: "height"
                    from: 0
                    to: root.height
                    duration: internal.secondScreenAnimDuration
                }
            }
        }

        pushExit: Transition {
            ParallelAnimation {
                PropertyAnimation {
                    target: firstScreen
                    property: "height"
                    from: firstScreen.height
                    to: 0
                    duration: internal.firstScreenAnimDuration
                }

                PropertyAnimation {
                    target: secondScreen
                    property: "height"
                    from: 0
                    to: root.height
                    duration: internal.secondScreenAnimDuration
                }
            }
        }

        popEnter: Transition {
            ParallelAnimation {
                PropertyAnimation {
                    target: firstScreen
                    property: "height"
                    from: 0
                    to: root.height
                    duration: internal.firstScreenAnimDuration
                }

                PropertyAnimation {
                    target: secondScreen
                    property: "height"
                    from: root.height
                    to: 0
                    duration: internal.secondScreenAnimDuration
                }
            }
        }

        popExit: Transition {
            PropertyAnimation {
                target: secondScreen
                property: "height"
                from: root.height
                to: 0
                duration: internal.secondScreenAnimDuration
            }
        }
    }

    ColumnLayout {
        id: firstScreen

        width: root.width
        height: root.height

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "roomId: " + root.roomIndex
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Name: " + root.roomName
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Status: " + root.roomStatus
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Players: " + root.roomPlayerCount + "/4"
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "Access: " + root.roomAccess
        }

        Text {
            Layout.leftMargin: internal.leftMargin
            text: "initial bet"
        }
    }

    Rectangle {
        id: secondScreen

        radius: root.radius
        width: root.width
        height: root.height
        color: "#8d9496"
        visible: false

        Button {
            id: btn

            text: "join"
            anchors.centerIn: parent
            palette {
                buttonText: "white"
                button: "green"
            }

            onClicked: {
                //TODO for testing
                Client.send(18, 0);
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onHoveredChanged: {
            if (mouseArea.containsMouse) {
                //TODO crutch
                secondScreen.visible = true;
                stack.push(secondScreen);
            } else {
                stack.pop();
            }
        }

        //TODO temp solution
        //propagateComposedEvents: true --> solution?
        onClicked: {
            btn.clicked();
        }
    }
}
