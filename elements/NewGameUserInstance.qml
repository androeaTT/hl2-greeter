import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 

ColumnLayout {
    id: root

    spacing: 3

    property alias realUsername: realUsernameItem.text
    property alias username: usernameItem.text
    property alias img: imgItem.source
    property bool selected: false 

    signal clicked()
    
    Text {
        id: realUsernameItem
        
        anchors.leftMargin: 2

        font.weight: 900
        font.pixelSize: 10
        font.family: "Trebuchet MS"
        text: "furryuser"
        color: root.selected ? "#FF6000" : "#FFF"
    }
    Text {
        id: usernameItem
        
        anchors.leftMargin: 2

        font.weight: 900
        font.pixelSize: 10
        font.family: "Trebuchet MS"
        text: "42"
        color: root.selected ? "#FF6000" : "#FFF"
    }
    Rectangle {
        width: imgItem.width + 20
        height: imgItem.height + 20

        color: root.selected ? "#FF6000" : "black"

        Image {
            id: imgItem
            source: ""
            anchors.centerIn: parent
        }
    }
    MouseArea {
        anchors.fill: parent

        z: root.z + 1
        
        onPressed: {
            clicked()
        }
    }
}