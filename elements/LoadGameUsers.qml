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

Column {
    id: root

    anchors.left: parent.left
    anchors.right: parent.right

    property int focusedIndex: 0

    Component.onCompleted: {
        for (var i = 0; i < root.children.length; i++) {
            const element = root.children[i]
            const staticI = i

            element.changeFocus.connect( function() {
                root.children[focusedIndex].focused = false
                element.focused = true
                focusedIndex = staticI
            })
        }
    }
}