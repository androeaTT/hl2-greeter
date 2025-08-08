import QtQuick
import QtQuick.Controls 
import QtQuick.VectorImage

Rectangle {
    id: root 
    anchors.fill: parent
    color: "#22000000"

    default property alias content: contentPlace.data
    property int scrollBarWidth: 14


    ScrollView {
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width - scrollBarWidth
        height: parent.height

        clip: true

        Column {
            id: contentPlace
            anchors.fill: parent
        }
    }

    Item {
        id: scrollBarBox
        anchors.right: parent.right
        height: parent.height
        width: scrollBarWidth

        Rectangle { //top button
            id: upButton

            color: "#22000000"
            height: scrollBarWidth
            width: scrollBarWidth
            anchors.top: parent.top

            VectorImage {
                source: "../assets/upArrow.svg"
                anchors.fill: parent

            }

            Borders {
                id: upBorders
                reverse: !topButtonMouseArea.pressed
                color1: "#555"
            }

            MouseArea {
                id: topButtonMouseArea
                z: parent.z + 1
                anchors.fill: parent
                onPressed: {}
            }
        }
        Rectangle {
            id: sliderBox 
            
            anchors.top: upButton.bottom
            anchors.bottom: downButton.top
            anchors.left: parent.left
            anchors.right: parent.right
            
            color: "#00000000"

            Rectangle {
                id: slider
                anchors.left: parent.left
                anchors.right: parent.right
                //temp
                height: 200
                color: "#aa9B9B9B"



                MouseArea {
                    id: sliderMArea

                    drag.target: parent
                    drag.axis: YAxis
                    drag.minimumY: sliderBox.y


                    anchors.fill: parent
                    z: root.z + 6
                    propagateComposedEvents: true
                    onPressed: () => {
                        
                        mouse.accepted = false
                    }
                }
            }
            
        }

        Rectangle { //bottom button
            id: downButton

            color: "#22000000"
            height: scrollBarWidth
            width: scrollBarWidth
            anchors.bottom: parent.bottom

            VectorImage {
                source: "../assets/downArrow.svg"
                anchors.fill: parent

            }

            Rectangle {
                width: parent.width
                height: 1
                color: bottomButtonMouseArea.pressed ? "#555" : "#aaa" 
                anchors.top: parent.top
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: bottomButtonMouseArea.pressed ? "#555" : "#aaa" 
                anchors.left: parent.left
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: bottomButtonMouseArea.pressed ? "#aaa" : "#555" 
                anchors.right: parent.right
            }
            
            Rectangle {
                width: parent.width
                height: 1
                color: bottomButtonMouseArea.pressed ? "#aaa" : "#555" 
                anchors.bottom: parent.bottom
            }

            MouseArea {
                id: bottomButtonMouseArea
                z: parent.z + 1
                anchors.fill: parent
                onPressed: {}
            }
        }
    }




    Borders {}
}