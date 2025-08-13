import QtMultimedia 
import QtQuick 
import QtQuick.Controls 
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import SddmComponents 2.0
import "elements"

Item {
    id: root


    TextConstants {
        id: textConstants
    }

    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "black" 
        z: 0 

    }

    MediaPlayer {
        id: hoverPlayer
        source: "assets/btns/buttonrollover.mp3"
        audioOutput: AudioOutput {}
    }

    MediaPlayer {
        id: clickPlayer
        source: "assets/btns/buttonclickrelease.mp3"
        audioOutput: AudioOutput {}
    }

    MediaPlayer {
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

    VideoOutput {
        id: background
        anchors.fill: parent
        focus: true
        z: 1
        
        Keys.onPressed: (event) => {
            if ( event.key === Qt.Key_Space) {
                if ( player.source.toString().endsWith("valve.mp4") ) {
                    root.start_loading()
                }  
            }
        }

        
    }

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

    FastBlur {
        id: bgBlur

        source: background
        radius: 42
        anchors.fill: parent
        visible: false
        z: 2
    }

    Rectangle {
        width: 100
        height: 50
        id: loadingBox
        visible: false
        color: "#000"
        radius: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        z: 3

        Text {
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "#fff"
            text: "Loading.."
        }

    }

    Timer {
            id: timerGui
            interval: 2000
            running: false
            repeat: false 
            onTriggered: {
                start_gui()
            }
    }

    SourceWindowsSurface {
        id: windows
        z: 5

        SourceWindow {
            id: newGameWindow
            visible: false
            width: 620
            height: 320
            insideMargin: 20

            basez: parent.z + 1
            x: root.width / 2 - 310
            y: root.height / 2 - 130

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
            visible: false
            width: 480
            height: 450
            insideMargin: 5

            basez: parent.z + 1
            x: root.width / 2 - this.width / 2
            y: root.height / 2 - this.height / 2

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

                    anchors.topMargin: 10
                    anchors.top: loadTextBox.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

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

    ///Main menu buttons
    Rectangle {
        id: mainMenuButtonBox
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 80
        z:3
        height: buttonsColumn.implicitHeight
        width: 700
        color: "transparent"
        

        Column {
            anchors.fill: parent
            id: buttonsColumn
            spacing: 16

            Image {
                source: "assets/menuLogo.png"
                width: 568
                height: 42
            }

            Rectangle {
                id: spacerBtn0
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse1.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: " "
                }
            }

            Rectangle {
                anchors.topMargin: 80
                id: newGameBtn
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse2.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: "NEW GAME"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { root.hoverSound() }
                    onPressed: { root.buttonClick(0) }
                }

                HoverHandler {
                    id: mouse2
                    acceptedDevices: PointerDevice.AllDevices 
                    onGrabChanged: {
                        if (hovered) {
                            hoverSound()
                        }
                    }
                }
            }

            Rectangle {
                id: loadGameBtn
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse3.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: "LOAD GAME"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { root.hoverSound() }
                    onPressed: { root.buttonClick(1) }
                }

                HoverHandler {
                    id: mouse3
                    acceptedDevices: PointerDevice.AllDevices 
                    onGrabChanged: {
                        if (hovered) {
                            hoverSound()
                        }
                    }
                }
            }

            Rectangle {
                id: achievmentsBtn
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse4.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: "ACHIEVEMENTS"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { root.hoverSound() }
                    onPressed: { root.buttonClick(2) }
                }

                HoverHandler {
                    id: mouse4
                    acceptedDevices: PointerDevice.AllDevices 
                    onGrabChanged: {
                        if (hovered) {
                            hoverSound()
                        }
                    }
                }
            }

            Rectangle {
                id: spacerBtn1
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse5.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: " "
                }
            }

            Rectangle {
                id: optionsBtn
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse6.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: "OPTIONS"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { root.hoverSound() }
                    onPressed: { root.buttonClick(3) }
                }

                HoverHandler {
                    id: mouse6
                    acceptedDevices: PointerDevice.AllDevices 
                    onGrabChanged: {
                        if (hovered) {
                            hoverSound()
                        }
                    }
                }
            }

            Rectangle {
                id: quickBtn
                width: 100
                height: 16
                color: "transparent"
                Text {
                    color: mouse7.hovered ? "#d6d6d6" : "white"
                    font.family: "Trebuchet MS"
                    font.pixelSize: 16
                    text: "QUIT"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { root.hoverSound() }
                    onPressed: { root.buttonClick(4) }
                }

                HoverHandler {
                    id: mouse7
                    acceptedDevices: PointerDevice.AllDevices 
                    onGrabChanged: {
                        if (hovered) {
                            hoverSound()
                        }
                    }
                }
            }

        }

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
}
