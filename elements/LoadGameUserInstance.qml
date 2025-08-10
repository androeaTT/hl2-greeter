import QtQuick

Item {
    id: root

    anchors.left: parent.left
    anchors.right: parent.right
    height: 200

    Item {
        id: leftPlace

        anchors.left: parent.left
        anchors.right: rightPlace.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Rectangle {
            id: imageBox

            
        }
    }
    Column {
        id: rightPlace 

        anchors.left: leftPlace.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    }
}