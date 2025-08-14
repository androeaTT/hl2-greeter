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
import QtQuick.Layouts
import QtQuick.Controls 
import SddmComponents

Item {
    id: root

    property int indexRp: 0
    property int selectedPage: 0

    TextConstants {
        id: textConstants
    }

    RowLayout {
        id: usersRow

        Repeater {
            model: Math.ceil( userModel.count / 3 )

            RowLayout {
                spacing: 10
                visible: selectedPage == usersRow.children.indexOf(this)
            }
        }


    }


    function addToRoot(username, realname) {
        indexRp = indexRp + 1
        var c = Qt.createComponent("NewGameUserInstance")
        c.createObject(
            usersRow.children[
                Math.ceil( indexRp / 3 )
            ],
            {
                username: username,
                realUsername: realname
            }
        )
    } 

    Repeater {
        id: mainRepeater
        
        model: userModel

        Text {
            text: model.name
        }

        delegate: Item {
            Component.onCompleted: {
                root.addToRoot(model.name, model.realName)
            }
        }
    }
}