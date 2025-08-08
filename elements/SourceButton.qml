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


    Rectangle {
        width: root.width
        height: 1
        color: buttonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
        anchors.top: parent.top
    }
    
    Rectangle {
        width: 1
        height: root.height
        color: buttonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
        anchors.left: parent.left
    }
    
    Rectangle {
        width: 1
        height: root.height
        color: buttonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
        anchors.right: parent.right
    }
    
    Rectangle {
        width: root.width
        height: 1
        color: buttonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
        anchors.bottom: parent.bottom
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