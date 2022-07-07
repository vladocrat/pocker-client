import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import LoginController 1.0
import Client 1.0
import Globals 1.0

Image {
    id: root

    signal loginRequired();
    signal registrationSucessful();
    signal registrationFailed(var msg);
    signal failedToSendRequest();

    property int fontPointSize: 13;

    FormBox {
        id: box

        width: 400
        height: 350

        anchors {
            horizontalCenter: root.horizontalCenter
            verticalCenter: root.verticalCenter
        }

        ColumnLayout {

            width: 200
            height: box.height - 100
            anchors {
                horizontalCenter: box.horizontalCenter
                verticalCenter: box.verticalCenter
            }

            Keys.onReturnPressed: {
                sendBtn.clicked();
            }

            Text {
                id: registrationText

                Layout.alignment: Qt.AlignHCenter
                text: "Registration"
                color: "#6c1e37"
                font {
                    pointSize: 20
                    family: Globals.fontFamily
                    bold: true
                }
            }

            FormTextField {
                id: login

                Layout.fillWidth: true
                focus: true
                placeholderText: "login"
                font {
                   pointSize: root.fontPointSize
                   family: Globals.fontFamily
                }
            }

            FormTextField {
                id: email

                Layout.fillWidth: true
                placeholderText: "example@gmail.com"
                //TODO add mask
                font {
                   pointSize: root.fontPointSize
                   family: Globals.fontFamily
                }
            }

            FormTextField {
                id: password

                Layout.fillWidth: true
                placeholderText: "password"
                font {
                   pointSize: root.fontPointSize
                   family: Globals.fontFamily
                }
            }

            Connections {
                target: Client

                function onRegistrationSuccessful() {
                    root.registrationSucessful();
                }

                function onRegistrationFailed(msg) {
                    root.registrationFailed(msg);
                }
            }

            FormSendButton {
                id: sendBtn

                Layout.fillWidth: true
                text: "Register"
                iconSource: "file:///C:/image/arrows.png"
                height: password.height

                onClicked: {
                    if (!LoginController.registerUser(login.text, email.text, password.text)) {
                        root.failedToSendRequest();
                    }
                }
            }

            HyperLink {
                width: password.width
                height: password.height
                hyperLinkText.text: "log in"

                onClicked: {
                    root.loginRequired();
                }
            }
        }
    }
}


