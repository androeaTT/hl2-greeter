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



TextField {
    id: root

    topPadding: 0
    bottomPadding: 0
    leftPadding: 4
    rightPadding: 4 

    color: "#fff"

    background: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right

        border.color: "transparent"
        color: "#22000000"

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
}