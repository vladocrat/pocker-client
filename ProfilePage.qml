import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import User 1.0
import Client 1.0

ColumnLayout {
    id: root

    Row {
        Text {
            text: "Username: "
        }
        Text {
            color: "red"
            text: User.name
        }
    }

    Row {
        Text {
            text: "email: "
        }
        Text {
            color: "red"
            text: User.email
        }
    }

    Row {
        Text {
            text: "pfp: "
        }
        Text {
            color: "red"
            text: User.pfpLink
        }
    }

    Button {
        text: "send hello";

        onClicked: {
            Client.sendCommand(0);
        }
    }
}
