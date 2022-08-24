import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import RoomModel 1.0
import Client 1.0
import Globals 1.0
import RoomController 1.0

Rectangle {
    id: root

    property int roomIndex: -100
    property string roomName: "default"
    property string roomStatus: "default"
    property string roomAccess: "default"
    property int roomMaxPlayerCount: 0
    property int roomPlayerCount: 0
    property int roomInitialBet: 0
    property string backGroundColor: "#6254b8"

    border.width: 1
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 7
        verticalOffset: 12
        samples: 16
        color: "#19202b"
    }

    Item {
        id: internal

        property int leftMargin: 5
        property int topMargin: 4
        property int secondScreenAnimDuration: 50
        property int firstScreenAnimDuration: 0
    }

    StackView {
        id: stack

        anchors.fill: parent
        initialItem: firstScreen

        pushEnter: Transition {
            PropertyAnimation {
                target: secondScreen
                property: "height"
                from: 0
                to: root.height
                duration: internal.secondScreenAnimDuration
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                target: secondScreen
                property: "height"
                from: 0
                to: root.height
                duration: internal.secondScreenAnimDuration
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                target: secondScreen
                property: "height"
                from: root.height
                to: 0
                duration: internal.secondScreenAnimDuration
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

    Item {
        id: firstScreen

        width: root.width
        height: root.height

        Rectangle {
            color: root.backGroundColor
            width: firstScreen.width
            height: firstScreen.height
            radius: root.radius

            ColumnLayout {
                Column {
                    Layout.leftMargin: internal.leftMargin
                    Layout.topMargin: internal.topMargin

                    Text {
                        Layout.leftMargin: internal.leftMargin
                        Layout.topMargin: 3
                        text: root.roomName
                        color: "white"
                        font {
                            family: Globals.fontFamily
                            pointSize: 16
                        }
                    }

                    Row {
                        Text {
                            Layout.leftMargin: internal.leftMargin
                            text: root.roomStatus
                            color: "#a7a9fa"
                            font {
                                family: Globals.fontFamily
                                pointSize: 9
                            }
                        }

                        Image {
                            width: 15
                            height: 15
                            source: if (root.roomAccess === "Private") {
                                        return "images/lock.png";
                                    } else {
                                        return "images/unlock.png";
                                    }
                        }
                    }
                }

                Item {
                    Layout.leftMargin: internal.leftMargin
                    height: root.height / 4
                }

                Row {
                    Layout.leftMargin: internal.leftMargin

                    Text {
                        id: betText

                        Layout.leftMargin: internal.leftMargin
                        text: "Initial bet:"
                        color: "white"
                        font {
                            family: Globals.fontFamily
                            pointSize: 10
                        }
                    }

                    Text {
                        text: " $" + root.roomInitialBet
                        color: "#d9c125"
                        font.pointSize: 10
                    }
                }
            }
        }

        Rectangle {
            color: root.backGroundColor
            width: firstScreen.width / 3
            height: firstScreen.height
            anchors.right: firstScreen.right
            radius: root.radius

            Rectangle {
                width: firstScreen.width / 5
                height: firstScreen.height / 3
                radius: root.radius
                color: "#4e438c"
                anchors.centerIn: parent

                Text {
                    color: "white"
                    text: root.roomPlayerCount + "/" + root.roomMaxPlayerCount
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }
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
                RoomController.joinRoom(root.roomIndex);
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
