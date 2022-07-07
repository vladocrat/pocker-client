import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12
import Globals 1.0
import LoginController 1.0
import Client 1.0

Image {
    id: root

    signal registrationRequired();
    signal loginSuccessful();
    signal loginFailed(var msg);
    signal failedToSendRequest();

    property int fontPointSize: 13;

    FormBox {
        id: box

        width: 400
        height: 300
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        ColumnLayout {
            width: 200
            height: box.height - 50

            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            Keys.onReturnPressed: {
                sendBtn.clicked();
            }

            Text {
                id: loginText

                Layout.alignment: Qt.AlignHCenter
                text: "Login"
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

                onTextChanged: {
                    login.text = login.text.replace(/\s+/g,'')
                }
            }

            FormTextField {
                id: password

                Layout.fillWidth: true
                placeholderText: "password"
                echoMode: TextInput.Password
                font {
                    pointSize: root.fontPointSize
                    family: Globals.fontFamily
                }

                onTextChanged: {
                    password.text = password.text.replace(/\s+/g,'')
                }
            }

            Connections {
                target: Client

                function onLoginSuccessful() {
                    root.loginSuccessful();
                }

                function onLoginFailed(msg) {
                    root.loginFailed(msg);
                }
            }

            FormSendButton {
                id: sendBtn

                Layout.fillWidth: true
                height: password.height
                text: "Log In"
                iconSource: "file:///C:/image/arrows.png"

                onClicked: {
                    if ((login.text.length < 3 || login.text.length === 0) &&
                            (password.text.length === 0 || password.text.length < 3)) {
                        //TODO show error?
                        console.log("fields empty or not enough chars");
                        return;
                    }

                    if (!LoginController.login(login.text, password.text)) {
                        root.failedToSendRequest();
                    }
                }
            }

            HyperLink {
                width: password.width
                height: password.height
                hyperLinkText.text: "create a new account"

                onClicked: {
                    root.registrationRequired();
                }
            }
        }
    }
}
