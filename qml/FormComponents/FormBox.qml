import QtQuick 2.0
import QtGraphicalEffects 1.12

//TODO make layout
Rectangle {
    id: root

    border.width: 4
    radius: 8
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 12
    }
}
