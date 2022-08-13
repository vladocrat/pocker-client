import QtQuick 2.0

Item {
    id: root

    property int animationDuration: 350

    signal clicked();

    Rectangle {
        id: bar1

        x: 2
        y: 5
        width: 20
        height: 2
        color: "black"
        antialiasing: true
    }

    Rectangle {
        id: bar2

        x: 2
        y: 10
        width: 20
        height: 2
        color: "black"
        antialiasing: true
    }

    Rectangle {
        id: bar3

        x: 2
        y: 15
        width: 20
        height: 2
        color: "black"
        antialiasing: true
    }

    state: "open"
    states: [
        State {
            name: "closed"
        },

        State {
            name: "open"

            PropertyChanges {
                target: bar1
                rotation: 45
                y: bar2.y
                x: bar2.x
            }

            PropertyChanges {
                target: bar3
                rotation: -45
                y: bar2.y
                x: bar2.x
            }

            PropertyChanges {
                target: bar2
                rotation: 45
                visible: false
            }
        }
    ]

    transitions: [
        Transition {
            RotationAnimation {
                target: root
                direction: RotationAnimation.Clockwise
                duration: root.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: bar1
                properties: "rotation, width, x, y"
                duration: root.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: bar2
                properties: "rotation, width, x, y"
                duration: root.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: bar3
                properties: "rotation, width, x, y"
                duration: root.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    ]

    MouseArea {
        anchors.fill: root

        onClicked: {
            root.clicked();
        }
    }
}
