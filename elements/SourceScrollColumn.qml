import QtQuick
import QtQuick.Controls 
import QtQuick.VectorImage

Rectangle {
    id: root 
    anchors.fill: parent
    color: "#22000000"

    default property alias content: contentPlace.data
    property int scrollBarWidth: 16


    ScrollView {
        id: scroll

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: scrollBarBox.left
        height: parent.height


        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

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

            Rectangle {
                width: parent.width
                height: 1
                color: topButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
                anchors.top: parent.top
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: topButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
                anchors.left: parent.left
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: topButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
                anchors.right: parent.right
            }
            
            Rectangle {
                width: parent.width
                height: 1
                color: topButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
                anchors.bottom: parent.bottom
            }

            MouseArea {
                id: topButtonMouseArea
                z: parent.z + 1
                anchors.fill: parent
                onPressed: {
                    if (slider.y - 10 >= 0) {
                        slider.y = slider.y - 10
                    } else {
                        slider.y = 0
                    }
                }
            }
        }
        Rectangle {
            id: sliderBox 
            
            anchors.top: upButton.bottom
            anchors.bottom: downButton.top
            anchors.left: parent.left
            anchors.right: parent.right
            
            color: "#cc9C9B9B"

            Rectangle {
                id: slider

                width: scrollBarWidth
                height: scroll.height / (contentPlace.height / sliderBox.height) > sliderBox.height ? 
                    sliderBox.height : 
                    scroll.height / (contentPlace.height / sliderBox.height)
                color: "#9B9B9B"

                onYChanged: {
                    console.log("OwO: " + y)
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#aaF6F6F6"
                    anchors.top: parent.top
                }
                
                Rectangle {
                    width: 1
                    height: parent.height
                    color: "#aaF6F6F6"
                    anchors.left: parent.left
                }
                
                Rectangle {
                    width: 1
                    height: parent.height
                    color: "#aa2f2f2f"
                    anchors.right: parent.right
                }
                
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#aa2f2f2f"
                    anchors.bottom: parent.bottom
                }


                MouseArea {
                    id: sliderMArea

                    drag.target: slider
                    drag.axis: Drag.YAxis
                    drag.minimumY: upButton.y
                    drag.maximumY: downButton.y - downButton.height - height


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
                color: downButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
                anchors.top: parent.top
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: downButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
                anchors.left: parent.left
            }
            
            Rectangle {
                width: 1
                height: parent.height
                color: downButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
                anchors.right: parent.right
            }
            
            Rectangle {
                width: parent.width
                height: 1
                color: downButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
                anchors.bottom: parent.bottom
            }

            MouseArea {
                id: downButtonMouseArea
                z: parent.z + 1
                anchors.fill: parent
                onPressed: {
                    if (slider.y + 10 <= 245) {
                        slider.y = slider.y + 10
                    } else {
                        slider.y = 245
                    }
                }
            }
        }
    }

    Binding {
        target: slider
        property: "y"
        value: (scroll.children[0].contentY / (contentPlace.height - scroll.height)) * (sliderBox.height - slider.height)
    }

    Binding {
        target: scroll.children[0]
        property: "contentY"
        value: (slider.y / (sliderBox.height - slider.height)) * (contentPlace.height - scroll.height)
    }


    Rectangle {
        width: parent.width
        height: 1
        color: "#aaF6F6F6"
        anchors.top: parent.top
    }
    
    Rectangle {
        width: 1
        height: parent.height
        color: "#aaF6F6F6"
        anchors.left: parent.left
    }
    
    Rectangle {
        width: 1
        height: parent.height
        color: "#aa2f2f2f"
        anchors.right: parent.right
    }
    
    Rectangle {
        width: parent.width
        height: 1
        color: "#aa2f2f2f"
        anchors.bottom: parent.bottom
    }
}