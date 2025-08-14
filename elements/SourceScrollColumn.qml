import QtQuick
import QtQuick.Controls 
import QtQuick.VectorImage

Rectangle {
    id: root 
    color: "#22000000"

    default property alias content: contentPlace.data
    property int scrollBarWidth: 16
    property alias spacing: contentPlace.spacing
    property alias contAnchors: contentPlace.anchors


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

            anchors.top: parent.top

            height: scrollBarWidth
            width: scrollBarWidth

            color: "#22000000"

            VectorImage {
                source: "../assets/upArrow.svg"
                anchors.fill: parent

            }

            Rectangle {
                width: parent.width
                height: 1

                anchors.top: parent.top

                color: topButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
            }
            
            Rectangle {
                width: 1
                height: parent.height

                anchors.left: parent.left

                color: topButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
            }
            
            Rectangle {
                width: 1
                height: parent.height

                anchors.right: parent.right

                color: topButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
            }
            
            Rectangle {
                width: parent.width
                height: 1

                anchors.bottom: parent.bottom

                color: topButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
            }

            MouseArea {
                id: topButtonMouseArea

                anchors.fill: parent

                z: parent.z + 1

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
                    
                    anchors.top: parent.top
                    
                    color: "#aaF6F6F6"
                }
                
                Rectangle {
                    width: 1
                    height: parent.height
                    
                    anchors.left: parent.left
                    
                    color: "#aaF6F6F6"
                }
                
                Rectangle {
                    width: 1
                    height: parent.height
                    
                    anchors.right: parent.right
                    
                    color: "#aa2f2f2f"
                }
                
                Rectangle {
                    width: parent.width
                    height: 1
                    
                    anchors.bottom: parent.bottom
                    
                    color: "#aa2f2f2f"
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

            anchors.bottom: parent.bottom
            
            width: scrollBarWidth
            height: scrollBarWidth

            color: "#22000000"

            VectorImage {
                source: "../assets/downArrow.svg"
                anchors.fill: parent

            }

            Rectangle {
                width: parent.width
                height: 1

                anchors.top: parent.top
                
                color: downButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
            }
            
            Rectangle {
                width: 1
                height: parent.height
                
                anchors.left: parent.left
                
                color: downButtonMouseArea.pressed ? "#aa2f2f2f" : "#aaF6F6F6"
            }
            
            Rectangle {
                width: 1
                height: parent.height

                anchors.right: parent.right
                
                color: downButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
            }
            
            Rectangle {
                width: parent.width
                height: 1
                
                anchors.bottom: parent.bottom
                
                color: downButtonMouseArea.pressed ? "#aaF6F6F6" : "#aa2f2f2f" 
            }

            MouseArea {
                id: downButtonMouseArea

                anchors.fill: parent

                z: parent.z + 1
                
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

        anchors.top: parent.top
        
        color: "#aa2f2f2f"
    }
    
    Rectangle {
        width: 1
        height: parent.height
        
        anchors.left: parent.left
        
        color: "#aa2f2f2f"
    }
    
    Rectangle {
        width: 1
        height: parent.height
        
        anchors.right: parent.right
        
        color: "#aaF6F6F6"
    }
    
    Rectangle {
        width: parent.width
        height: 1
        
        anchors.bottom: parent.bottom
        
        color: "#aaF6F6F6"
    }
}