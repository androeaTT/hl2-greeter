// Theme for SDDM with Half-Life 2 GUI style
// Copyright (C) 2025  androeaTT
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.


import QtQuick
import QtQuick.Controls 

Rectangle {
    id: root 

    width: 620
    height: 320

    color: "#f7777777"
    radius: 7
    z: focused ? basez + 10 : basez
    
    property int basez: 0
    property alias title: titleItem.text
    property alias closable: close.visible
    property alias draggable: dragArea.visible
    property bool focused: false
    property Item windowsSurface: root.parent.parent
    property Item windowsPlace: root.parent
    property alias insideMargin: contentBox.anchors.margins
    default property alias content: contentBox.data
    
    onVisibleChanged: {
        if (root.visible) {
            windowsSurface.visibleWindows++
        } else {
            windowsSurface.visibleWindows--
        }
    }

    MouseArea {
        id: dragArea

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
            
            anchors.top: titleItem.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
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