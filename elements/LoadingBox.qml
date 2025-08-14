Rectangle {
    id: root

    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 20
        
    width: 100
    height: 50
    z: 3
        
    visible: false
    color: "#000"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pixelSize: 14
        color: "#fff"
        text: "Loading.."
    }
}