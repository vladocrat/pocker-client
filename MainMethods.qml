import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Client 1.0
import FieldManager 1.0

Item {
    id: root

    ColumnLayout {
        RowLayout {
            TextField {
                id: playersBet
                placeholderText: qsTr("bet")
                validator: RegExpValidator{regExp: /^[0-9,/]+$/}
            }

            Button {
                id: bet
                text: qsTr("bet")
                onClicked: {
                    if (playersBet.length > 0) {
                        Client.send(1, playersBet.text)
                    } else {
                        Client.send(1);
                    }
                }
            }
        }

        RowLayout {
            TextField {
                id: raiseBy
                placeholderText: qsTr("raise")
                validator: RegExpValidator{regExp: /^[0-9,/]+$/}
            }

            Button {
                id: raise
                text: qsTr("raise")
                onClicked: {
                    if (raiseByse.length > 0) {
                        Client.send(3, raiseBy.text)
                    } else {
                        Client.send(3);
                    }
                }
            }
        }

        RowLayout {
            Button {
                id: fold
                text: qsTr("fold")
                onClicked: Client.send(2)
            }

            Button {
                id: check
                text: qsTr("check")
                onClicked: Client.send(6)
            }

            Button {
                id: allIn
                text: qsTr("all in")
                onClicked: Client.send(4)
            }

            Button {
                id: call
                text: qsTr("call")
                onClicked: Client.send(5)
            }


            Label {
                text: FieldManager.text
            }
        }
    }
}
