// Theme for sddm with half-life 2 gui style
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

    anchors.margins: 1
    
    height: 25
    width: textItem.width + (7 * 2) + 20

    property alias text: textItem.text
    signal clicked()

    color: "transparent"

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

        anchors.top: parent.top

        color: buttonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
    }
    
    Rectangle {
        width: 1
        height: root.height

        anchors.left: parent.left

        color: buttonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
    }
    
    Rectangle {
        width: 1
        height: root.height

        anchors.right: parent.right

        color: buttonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
    }
    
    Rectangle {
        width: root.width
        height: 1

        anchors.bottom: parent.bottom
        
        color: buttonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
    }
    
    MouseArea {
        id: buttonMouseArea

        anchors.fill: parent
        
        z: root.z + 1

        onPressed: {
            timer.running = true
        }
    }
    
    Text {
        id: textItem

        anchors.leftMargin: 7
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        z: root.z + 1

        font.pixelSize: 14
        font.family: "Tahoma"
        font.weight: 100
        
        text: "This is button"
        color: "#fff"
    }
}