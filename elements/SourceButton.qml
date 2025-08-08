import QtQuick
import QtQuick.Controls 

Rectangle {
    id: root

    property alias text: textItem.text
    signal clicked()

    height: 25
    width: textItem.width + (7 * 2) + 20
    color: "transparent"
    anchors.margins: 1

    Timer {
        id: timer
        interval: 100
        running: false
        repeat: false 

        onTriggered: {
            clicked()
        }
    }


    Borders {
        color1: "#555"
        reverse: !buttonMouseArea.pressed
    }
    
    MouseArea {
        id: buttonMouseArea
        z: root.z + 1
        anchors.fill: parent
        onPressed: {
            timer.running = true
        }
    }
    
    Text {
        id: textItem
        z: root.z + 1
        font.pixelSize: 14
        font.family: "Tahoma"
        font.weight: 100
        text: "This is button"
        color: "#fff"
        anchors.leftMargin: 7
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
}