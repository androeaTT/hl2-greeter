import QtQuick

Item {
    Rectangle {
        id: cancelNewGameButton
        z: 9
        height: 25
        width: 70
        color: "transparent"

        Rectangle {
            width: parent.width
            height: 1
            color: cancelNewGameButtonMouseArea.pressed ? "#555" : "#aaa"
            anchors.top: parent.top
        }

        Rectangle {
            width: 1
            height: parent.height
            color: cancelNewGameButtonMouseArea.pressed ? "#555" : "#aaa"
            anchors.left: parent.left
        }

        Rectangle {
            width: 1
            height: parent.height
            color: cancelNewGameButtonMouseArea.pressed ? "#aaa" : "#555"
            anchors.right: parent.right
        }

        Rectangle {
            width: parent.width
            height: 1
            color: cancelNewGameButtonMouseArea.pressed ? "#aaa" : "#555"
            anchors.bottom: parent.bottom
        }

        MouseArea {
            id: cancelNewGameButtonMouseArea
            z: 10
            anchors.fill: parent
        }

        Text {
            z: 10
            font.pixelSize: 14
            font.family: "Tahoma"
            font.weight: 100
            text: "Cancel"
            color: "#fff"
            anchors.leftMargin: 7
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
