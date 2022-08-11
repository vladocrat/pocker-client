import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import User 1.0
import Client 1.0

ColumnLayout {
    id: root

    property alias pic: img

    ProfileImage {
        id: img

        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        source: "images/arrows.png"
    }

    Text {
        id: username

        text: "Username: " + User.name
    }

    Text {
        id: email

        text: "email: " + User.email
    }

    Text {
        id: pfpLink

        text: "pfp: " + User.pfpLink
    }   
}

