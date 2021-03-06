import QtQuick 2.0
import QtQuick.Controls 2.14
import Globals 1.0

TextField {
    id: root

    property string textColor: "#308275"
    property alias backgroundRect: background

    color: root.textColor
    background: Rectangle {
        id: background

        radius: 4
        color: Globals.mainColor
    }
}
