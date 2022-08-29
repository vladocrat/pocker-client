import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Extras 1.4
import ModelController 1.0
import FormComponents 1.0
import Buttons 1.0
import Client 1.0

Popup {
    id: root

    signal roomCreationFailed(var msg)

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
            id: name

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth
            placeholderText: "enter name"
            focus: true
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

        Text {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth
            text: "initial bet: " + initialBetSlider.value
        }

        FormSlider {
            id: initialBetSlider

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth
            Layout.preferredHeight: 20
            from: 50
            to: 2500
            stepSize: 50
        }

        CustomToggleButton {
            id: toggleBtn

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth
            Layout.preferredHeight: 30
        }

        Item {
            id: item

            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth
            Layout.preferredHeight: 20
            visible: !toggleBtn.on

            Text {
                id: pswdText

                text: "password: "
            }

            TextInput {
                id: password

                anchors.left: pswdText.right
                focus: item.visible
                width: 40
                height: 15
                inputMask: "0000"
                selectByMouse: true

                Keys.onSpacePressed: {
                    return;
                }
            }
        }

        Connections {
            target: Client

            function roomCreationFailed(msg) {
                root.roomCreationFailed(msg)
            }
        }

        FormSendButton {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: root.inputFieldsWidth / 2
            Layout.preferredHeight: 35
            text: "Create"

            onClicked: {
                if (name.text.legth === 0) {
                    root.roomCreationFailed("Some info is wrong or missing");
                    return;
                }

                if (!toggleBtn.on && password.text.length < 4) {
                    root.roomCreationFailed("Some info is wrong or missing");
                    return;
                }

                if (!ModelController.createRoom(name.text, maxPlayersSlider.value,
                                            initialBetSlider.value, toggleBtn.on, password.text)) {
                    root.roomCreationFailed("Some info is wrong or missing");
                }

                root.close();
            }
        }
    }
}
