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
import QtQuick.Layouts
import QtQuick.Controls 

ColumnLayout {
    id: root

    spacing: 3

    property alias realUsername: realUsernameItem.text
    property alias username: usernameItem.text
    property alias img: imgItem.source
    property bool selected: false 

    signal clicked()
    
    Text {
        id: realUsernameItem
        
        anchors.leftMargin: 2

        font.weight: 900
        font.pixelSize: 10
        font.family: "Trebuchet MS"
        text: "furryuser"
        color: root.selected ? "#FF6000" : "#FFF"
    }
    Text {
        id: usernameItem
        
        anchors.leftMargin: 2

        font.weight: 900
        font.pixelSize: 10
        font.family: "Trebuchet MS"
        text: "42"
        color: root.selected ? "#FF6000" : "#FFF"
    }
    Rectangle {
        width: imgItem.width + 20
        height: imgItem.height + 20

        color: root.selected ? "#FF6000" : "black"

        Image {
            id: imgItem
            source: ""
            anchors.centerIn: parent
        }
    }
    MouseArea {
        anchors.fill: parent

        z: root.z + 1
        
        onPressed: {
            clicked()
        }
    }
}