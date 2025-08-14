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
import QtMultimedia 

Rectangle {
    id: root

    width: 100
    height: 16

    color: "transparent"

    property alias text: textItem.text
    property bool hover: false
    property bool soundEnabled: true
    signal entered()
    signal clicked()

    onEntered: {
        if (soundEnabled) {
            Qt.createQmlObject(`
                import QtMultimedia

                MediaPlayer {
                    autoPlay: true
                    source: "../assets/btns/buttonrollover.mp3"
                    audioOutput: AudioOutput {}
                }`, root
            )
        }
    }
    
    Text {
        id: textItem

        color: hover ? "#d6d6d6" : "#fff"
        font.family: "Trebuchet MS"
        font.pixelSize: 16
        text: "FURRY BUTTON)"
    }

    MouseArea {
        id: area

        anchors.fill: parent

        hoverEnabled: true

        onExited: {
            hover = false 
        }
        onEntered: { 
            root.entered() 
            hover = true 
        }
        onPressed: { root.clicked() }
    }
}