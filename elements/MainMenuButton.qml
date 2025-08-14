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