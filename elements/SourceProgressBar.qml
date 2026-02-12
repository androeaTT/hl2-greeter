// Theme for SDDM with Half-Life 2 GUI style
// Copyright (C) 2025-2026  androeaTT
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

    function computeRects() {
        const coefficient = rectCount / 100
        const toBeShowed = progress * coefficient 

        contentBox.children.forEach( ( e, i ) => {
            e.visible = toBeShowed >= i
        } )
    }

    property int progress: 100
    property real rectCount: width / 12

    color: "#22000000"

    width: 338
    height: 22

    Row {
        id: contentBox

        height: 19
        width: root.width - 10

        anchors.centerIn: parent

        spacing: 4

        Repeater {
            model: { Math.floor(rectCount) }

            Rectangle {
                anchors.bottom: parent.bottom

                height: 16
                width: 8

                color: "#fff"
                visible: true
            }
        }
    }

    onProgressChanged: {
        computeRects()
    }

    Component.onCompleted: {
        computeRects()
    }

    // Borders

    Rectangle {
        width: parent.width
        height: 1

        anchors.top: parent.top
        
        color: "#aa2f2f2f"
    }
    
    Rectangle {
        width: 1
        height: parent.height
        
        anchors.left: parent.left
        
        color: "#aa2f2f2f"
    }
    
    Rectangle {
        width: 1
        height: parent.height
        
        anchors.right: parent.right
        
        color: "#aaF6F6F6"
    }
    
    Rectangle {
        width: parent.width
        height: 1
        
        anchors.bottom: parent.bottom
        
        color: "#aaF6F6F6"
    }
}