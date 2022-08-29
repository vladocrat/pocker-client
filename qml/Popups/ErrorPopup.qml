import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import FormComponents 1.0
import Buttons 1.0

Popup {
    id: root

    property string errorMessage: "ERROR"
    property alias text: text

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    background: FormBox {}
    contentItem: ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        Text {
            id: text

            Layout.alignment: Qt.AlignCenter
            text: root.errorMessage
            font.pointSize: 20
            font.bold: true
        }

        FormSendButton {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 35
            Layout.preferredWidth: 90
            text: "OK"
            focus: true

            onClicked: {
                root.close();
            }
        }
    }
}


