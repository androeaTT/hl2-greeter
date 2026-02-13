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
    //      Properties    //
    ////////////////////////

    property var loginWindowsDump: []
    property int currentLoginUserId




    ////////////////////////
    //      Functions     //
    ////////////////////////

    /// random helpers
    function getRandomInt( min, max ) { return Math.floor(Math.random() * (max - min + 1)) + min }

    /// modes
    function startPasswordAuth( userid ) {
        currentLoginUserId = userid
        loginWindowsDump = []

        windows.windows.forEach( e => {
            loginWindowsDump.push( e.visible )
            e.visible = false
        } )

        mainMenu.visible = false
        player.pause()
        bgBlur.blur()

        loadsWindow.visible = true
        loginLoadBar.setBreak(1, () => {
            loginLoadBar.pause()
            loadsWindow.visible = false
            passwordWindow.visible = true
        } )
        loginLoadBar.startLoading()
    } 

    function startLoading() {
        player.stop()
        player.source = player.getRandomBgVideo()
        player.pause()
        bgBlur.visible = true
        loadingBox.visible = true
        timerGui.running = true
    }
    
    function startGui() {
        bgBlur.unblurLinear()
        loadingBox.visible = false
        player.play()
        player.loops = 99999
        mainMenu.visible = true
    }

    /// Users stuff
    function getUsername( index ) {
        const role = Qt.UserRole + 1
        const qtIndex = userModel.index( index, 0 )
        const username = userModel.data(qtIndex, role)
        
        return username
    }

    function getRealName( index ) {
        const role = Qt.UserRole + 2
        const qtIndex = userModel.index( index, 0 )
        return userModel.data(qtIndex, role)
    }

    function login( userid, passwd ) {  
        sddm.login( getUsername(userid), passwd, 4)  
    }



    ////////////////////////
    //       Backend      //
    ////////////////////////

    TextConstants { // sddm stuff
        id: textConstants
    }

    Timer { // timer for loading delay 
        id: timerGui

        interval: 2000
        running: false
        repeat: false 

        onTriggered: {
            startGui()
        }
    }

    MediaPlayer { //intro and background player
        id: player

        function getRandomBgVideo() { return ("assets/bgdir/" + getRandomInt(1, 7) + ".mp4") }

        source: "assets/valve.mp4"
        videoOutput: background
        audioOutput: AudioOutput {}
        autoPlay: false

        property bool isIntro: true

        onSourceChanged: {
            isIntro = source.toString().endsWith("/valve.mp4")
        }

        onPlayingChanged: {
            if ( isIntro ) {
                if (player.position > 300){
                    root.startLoading()
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
    //       Layout       //
    ////////////////////////

    VideoOutput { // Background video and intro output
        id: background

        anchors.fill: parent
        z: 1

        focus: true
        
        Keys.onPressed: (event) => {
            if ( player.isIntro ) {
                if ( event.key === Qt.Key_Space ) {
                    if (player.playing){
                        if (player.position > 300){
                            root.startLoading()
                        }
                    } else {
                        player.play()
                        spaceTextItem.visible = false
                    }
                }
            }
        }
    }

    FastBlur { // Blur on loading
        id: bgBlur

        function blurLinear(){
            blurBhv.enabled = true
            radius = initialRadius
        }
        function unblurLinear(){
            blurBhv.enabled = true
            radius = 0
        }
        function blur(){
            blurBhv.enabled = false
            radius = initialRadius
        }
        function unblur(){
            blurBhv.enabled = false
            radius = 0
        }

        property int initialRadius: 42

        anchors.fill: parent
        z: 2

        source: background
        visible: false
        radius: initialRadius

        Behavior on radius {
            id: blurBhv
            NumberAnimation {
                duration: 500
                easing.type: Easing.Linear
            }
        }
    }

    Text { //PRESS SPACE label. why? because sddm feels itself like google chrome and mute all autoplay sound
        id: spaceTextItem

        anchors.centerIn: parent
        z: 2

        color: "#8d8d8d"
        font.family: "Trebuchet MS"
        font.pixelSize: 32
        text: "PRESS SPACE"
    }
    
    LoadingBox { id: loadingBox }

    SourceWindowsSurface { // Windows surface
        id: windows

        z: 5

        SourceWindow { // New Game window
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

        SourceWindow { // Load Game window
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
                    anchors.topMargin: 5 
                    anchors.bottomMargin: 10
                    anchors.top: loadTextBox.bottom
                    anchors.bottom: loadButtons.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    LoadGameUsers {
                        id: loadUsers

                        spacing: 20

                        Repeater {
                            id: repeat
                            model: userModel

                            LoadGameUserInstance {
                                required property int index

                                userid: index
                                realName: getRealName(index)
                                name: getUsername(index)[0].toUpperCase() + getUsername(index).slice(1)
                            }
                        }
                    }
                }

                Row {
                    id: loadButtons

                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Row {
                        id: loadButtonsLeft
                        
                        width: parent.width / 2
                        layoutDirection: Qt.LeftToRight

                        SourceButton {
                            text: "Delete"
                            onClicked: { windows.showWindow(2) }
                        }
                    }
                    
                    Row {
                        id: loadButtonsRight

                        width: parent.width / 2
                        
                        spacing: 4
                        layoutDirection: Qt.RightToLeft

                        SourceButton {
                            text: "Cancel"
                            onClicked: { loadGameWindow.visible = false }
                        }
                        SourceButton {
                            text: "Load"
                            onClicked: { startPasswordAuth( loadUsers.focusedIndex ) }
                        }
                    }
                }
            }
        }

        SourceWindow { // coming soon window
            id: comingSoonWindow
            
            height: 120
            width: 340

            visible: false
            title: "COMING SOON"

            Text {
                color: "#fff"
                text: "This under development now("
            }
        }

        SourceWindow { // loading bar window
            id: loadsWindow
            
            height: 74
            width: 380

            x: root.width / 2 - width / 2
            y: root.height / 2 - height / 2

            visible: false
            title: "LOADING..."

            LoadingProgressBar {
                id: loginLoadBar

                visible: true
            }
        }

        SourceWindow { // password field window
            id: passwordWindow
            
            height: 135
            width: 290

            insideMargin: 10

            x: root.width / 2 - width / 2
            y: root.height / 2 - height / 2

            visible: false
            title: "Server require password"

            Column {
                anchors.fill: parent

                spacing: 5

                Item {
                    height: 1
                    width: 1
                }

                Text {
                    color: "#fff"
                    text: "To connect, type password:"
                }

                SourceInputField {
                    id: passwordField

                    width: parent.width - 1
                }
                
                Row {
                    width: parent.width

                    anchors.bottom: parent.bottom

                    spacing: 4
                    layoutDirection: Qt.RightToLeft

                    SourceButton {
                        id: cancelPasswordButton

                        text: "Cancel"
                    }
                    SourceButton {
                        id: connectPasswordButton

                        text: "Connect"
                        
                        onClicked: {
                            passwordWindow.visible = false
                            loadsWindow.visible = true

                            loginLoadBar.setBreak(3, () => {
                                login(currentLoginUserId, passwordField.text )
                            })
                            loginLoadBar.unpause()
                        }
                    }
                }

            }
        }
    }

    SourceMainMenu{ // Main menu
        id: mainMenu
        z: 3

        onButtonClick: function(buttonId){
            windows.showWindow(buttonId)
        }
    }
}
