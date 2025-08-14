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

Rectangle {
    id: root

    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 20
        
    width: 100
    height: 50
    z: 3
        
    visible: false
    color: "#000"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pixelSize: 14
        color: "#fff"
        text: "Loading.."
    }
}