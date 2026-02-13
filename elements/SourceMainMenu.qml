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
import QtMultimedia

Rectangle {
        id: root

        onButtonClick: function( buttonId ) {
            clickPlayer.stop()
            clickPlayer.play()
        }

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 80
        
        height: buttonsColumn.implicitHeight
        width: 700

        signal buttonClick(int buttonId)
        
        visible: false
        color: "transparent"
        

        MediaPlayer { // audio player for button click 
            id: clickPlayer

            source: "../assets/btns/buttonclickrelease.mp3"
            audioOutput: AudioOutput {}
        }

        Column {
            id: buttonsColumn

            anchors.fill: parent
            
            spacing: 16

            Image {
                width: 568
                height: 42

                source: "../assets/menuLogo.png"
            }

            MainMenuButton {
                soundEnabled: false
                text: " "
            }

            MainMenuButton {
                text: "NEW GAME"

                onClicked: { root.buttonClick(0) }
            }

            MainMenuButton {
                text: "LOAD GAME"

                onClicked: { root.buttonClick(1) }
            }

            MainMenuButton {
                text: "ACHIEVMENTS"

                onClicked: { root.buttonClick(2) }
            }

            MainMenuButton {
                soundEnabled: false
                text: " "
            }

            MainMenuButton {
                text: "OPTIONS"

                onClicked: { root.buttonClick(3) }
            }

            MainMenuButton {
                text: "QUIT"

                onClicked: { root.buttonClick(4) }
            }
        }
    }