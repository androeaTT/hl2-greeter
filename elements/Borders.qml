import QtQuick

Item {
    id: root

    property bool reverse: false
    property string color1: "#444"
    property string color2: "#aaa"

    anchors.fill: parent

    Rectangle {
        width: root.width
        height: 1
        color: reverse ? color2 : color1
        anchors.top: root.top
    }
    
    Rectangle {
        width: 1
        height: root.height
        color: reverse ? color2 : color1
        anchors.left: root.left
    }
    
    Rectangle {
        width: 1
        height: root.height
        color: reverse ? color1 : color2
        anchors.right: root.right
    }
    
    Rectangle {
        width: root.width
        height: 1
        color: reverse ? color1 : color2
        anchors.bottom: root.bottom
    }
}