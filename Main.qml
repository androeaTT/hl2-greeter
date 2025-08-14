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


import QtMultimedia 
import QtQuick 
import QtQuick.Controls 
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import SddmComponents 2.0
import "elements"

Item {
    id: root

    ////////////////////////
    //      Invisible     //
    ////////////////////////

    TextConstants { // sddm stuff
        id: textConstants
    }

    MediaPlayer { // audio player for button click 
        id: clickPlayer

        source: "assets/btns/buttonclickrelease.mp3"
        audioOutput: AudioOutput {}
    }

    Timer { // timer for loading delay 
        id: timerGui

        interval: 2000
        running: false
        repeat: false 

        onTriggered: {
            start_gui()
        }
    }

    MediaPlayer { //intro and background player
        id: player

        source: "assets/valve.mp4"
        videoOutput: background
        autoPlay: true

        audioOutput: AudioOutput {}
        onPlayingChanged: {
            if (playing == false) {
                if ( player.source.toString().endsWith("valve.mp4") ) {
                    root.start_loading()
                }
            }
        }
    }

    Rectangle { // white corners fix
        anchors.fill: parent
        color: "black" 
        z: 0 
    }

    ////////////////////////
    //      Functions     //
    ////////////////////////

    function login() {

    }
    
    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min
    }

    function hoverSound() {
        hoverPlayer.stop()
        hoverPlayer.play()
    }

    function buttonClick( buttonId ) {
        clickPlayer.stop()
        clickPlayer.play()

        windows.showWindow(buttonId)
    } 

    function start_loading() {
        player.stop()
        player.source = "assets/bgdir/" + getRandomInt(1, 7) + ".mp4"
        player.pause()
        bgBlur.visible = true
        loadingBox.visible = true
        timerGui.running = true
    }
    
    function start_gui() {
        bgBlur.visible = false
        loadingBox.visible = false
        player.play()
        player.loops = 99999
        mainMenuButtonBox.visible = true
    }

    ////////////////////////
    //       Layout       //
    ////////////////////////


    VideoOutput { // Background video and intro output
        id: background

        anchors.fill: parent
        z: 1

        focus: true
        
        Keys.onPressed: (event) => {
            if ( event.key === Qt.Key_Space) {
                if ( player.source.toString().endsWith("valve.mp4") ) {
                    root.start_loading()
                }  
            }
        }
    }

    FastBlur { // Blur when loading
        id: bgBlur

        anchors.fill: parent
        z: 2

        source: background
        visible: false
        radius: 42
    }
    
    LoadingBox { id: loadingBox }


    // Windows surface
    SourceWindowsSurface {
        id: windows

        z: 5

        SourceWindow {
            id: newGameWindow

            width: 620
            height: 320

            basez: parent.z + 1
            x: root.width / 2 - 310
            y: root.height / 2 - 130

            visible: false
            insideMargin: 20
            title: "NEW GAME"

            Image {
                source: "assets/border.png"
                z: 9
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            NewGameUsers {}

            RowLayout {
                spacing: 12

                anchors.bottom: parent.bottom
                anchors.right: parent.right

                //start button
                SourceButton {
                    id: startNewGameButton
                    text: "Start new game"
                    z: 9

                    onClicked: {
                        login()
                    }
                }

                //cancel button
                SourceButton {
                    id: cancelNewGameButton
                    text: "Cancel"
                    z: 9
                    onClicked: {
                        newGameWindow.visible = false
                    }
                }
            }
        }

        SourceWindow {
            id: loadGameWindow

            basez: parent.z + 1
            x: root.width / 2 - this.width / 2
            y: root.height / 2 - this.height / 2

            width: 480
            height: 450
            
            visible: false
            insideMargin: 5
            title: "LOAD GAME"

            Column {
                anchors.fill: parent

                Item {
                    id: loadTextBox

                    height: 20

                    Text {
                        id: loadtext   

                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right  

                        font.pixelSize: 14
                        font.family: "Trebuchet MS"
                        color: "#e0e0e0"
                        text: "Select a saved game in the list below, then click 'Load game'"
                    }
                }

                SourceScrollColumn {
                    id: loadscrollcol

                    contAnchors.topMargin: 10
                    anchors.top: loadTextBox.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    spacing: 20

                    Repeater {
                        model: userModel
                            
                        LoadGameUserInstance {
                            required property int index

                            userid: index
                            realName: modelData.realName
                            name: modelData.name
                        }
                    }
                }
            }
        }
    }

    /// Main menu
    Rectangle {
        id: mainMenuButtonBox

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 80
        
        height: buttonsColumn.implicitHeight
        width: 700
        z:3
        
        visible: false
        color: "transparent"
        

        Column {
            id: buttonsColumn

            anchors.fill: parent
            
            spacing: 16

            Image {
                width: 568
                height: 42

                source: "assets/menuLogo.png"
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
}
