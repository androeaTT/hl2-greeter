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
import QtMultimedia


Item {
    id: root

    property string src: ""

    Component.onCompleted: {
        console.log("OwO -_-: " + src)
        Qt.createQmlObject(`
            import QtMultimedia

            MediaPlayer {
                autoPlay: true
                source: "` + src + `"
                audioOutput: AudioOutput {}
            }`, root
        )
    }
}