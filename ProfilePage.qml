import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import User 1.0
import Client 1.0

ColumnLayout {
    id: root

    ProfileImage {
        width: 40
        height: 40
        source: "file:///C:/Users/sherlock/Desktop/img.jpg"
    }

    Text {
        text: "Username: " + User.name
    }

    Text {
        text: "email: " + User.email
    }

    Text {
        text: "pfp: " + User.pfpLink
    }
}
