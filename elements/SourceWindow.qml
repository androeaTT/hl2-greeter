import QtQuick
import QtQuick.Controls 

Rectangle {
    id: root 
    color: "#f7777777"
    radius: 7
    width: 620
    height: 320

    property int basez: 0
    z: focused ? basez + 10 : basez

    property alias title: titleItem.text
    property alias closable: close.visible
    property bool focused: false
    property Item windowsSurface: root.parent.parent
    property Item windowsPlace: root.parent
    default property alias content: contentBox.data
    
    
    onVisibleChanged: {
        if (root.visible) {
            windowsSurface.visibleWindows++
        } else {
            windowsSurface.visibleWindows--
        }
    }
    
    


    MouseArea {
        z: root.z + 3
        anchors.top: parent.top
        anchors.rightMargin: 25
        height: 30
        width: parent.width - 25
        drag.target: parent
        drag.axis: Drag.XAndYAxis
        drag.filterChildren: true    
    }
    
    Rectangle {
        z: root.z + 1
        anchors.fill: parent
        anchors.margins: 10
        anchors.leftMargin: 15 
        color: "#00000000"

        Text {
            id: titleItem
            font.weight: 800
            font.family: "Trebuchet MS"
            text: "This is the title) owo"
            z: root.z + 2
            color: "#FFF"
        }

        Image {
            id: close
            visible: true
            source: "../assets/x.png"
            anchors.right: parent.right
            anchors.top: parent.top
            height: 14
            width: 14
            z: root.z + 4
            
            MouseArea {
                anchors.fill: parent
                z: root.z + 5
                onPressed: {
                    root.visible = false
                }
            }
        }

        Column {
            id: contentBox
            anchors.fill: parent
            anchors.margins: 20
        }
    }
    MouseArea {
        anchors.fill: parent
        drag.filterChildren: true
        z: root.z + 6
        propagateComposedEvents: true
        onPressed: (mouse)=> {
            windowsSurface.changeFocus(root)
            mouse.accepted = false
        }
    }
}