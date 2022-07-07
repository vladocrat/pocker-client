import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Extras 1.4

Popup {
    id: root

    property int inputFieldsWidth: root.width / 1.25

    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    background: FormBox { }
    contentItem: ColumnLayout {
            anchors.fill: parent

            Text {
                Layout.alignment: Qt.AlignCenter
                font.pointSize: 15
                text: "Create room"
            }

            FormTextField {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth
                placeholderText: "enter name"
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth
                text: "max players: " +  maxPlayersSlider.value
            }

            FormSlider {
                id: maxPlayersSlider

                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth
                Layout.preferredHeight: 20
                from: 2
                to: 4
            }

            CustomToggleButton {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth
                Layout.preferredHeight: 30
            }

            FormTextField {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth
                placeholderText: "choose initial bet"
            }

            FormSendButton {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.inputFieldsWidth / 2
                Layout.preferredHeight: 35
                text: "Create"
            }
        }
}
