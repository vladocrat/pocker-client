import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property string source: ""

    Image {
        id: img

        width: root.width
        height: root.height
        fillMode: Image.PreserveAspectCrop
        source: root.source
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
    }

    Rectangle {
        id: mask

        width: img.width
        height: img.height
        radius: img.width / 2
        visible: false
    }
}
