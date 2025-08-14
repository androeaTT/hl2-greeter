import QtQuick
import QtQuick.Controls 

Rectangle {
    id: root

    anchors.left: parent.left
    anchors.right: parent.right

    color: "transparent"
    height: 120

    property int userid: 0
    property alias name: nameItem.text
    property alias realName: realItem.text

    property string textColor: "#fff"
    property int fontSize: 14

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function get_user_image(userid) { //todo: userid func
        return "../assets/chapters/chapter" + getRandomInt(1, 14) + ".png"
    }

    function get_save_type(userid) { //todo: userid func
        if ( getRandomInt(0, 1) ) {
            return "QUICK SAVE"
        } else {
            return "AUTO SAVE"
        }
    }

    Row {
        id: mainRow

        anchors.fill: parent

        Item {
            id: leftPlace

            width: parent.width / 2
            height: parent.height

            Rectangle {
                id: imageBox

                color: "#000"

                anchors.centerIn: parent

                width: image.width + 16
                height: image.height + 16

                Image {
                    id: image

                    width: 179
                    height: 99

                    anchors.centerIn: parent

                    source: get_user_image(userid)
                }
            }
        }
        Item {
            id: rightPlace 

            width: parent.width / 2
            height: parent.height

            Column {
                Text {
                    id: nameItem
                    text: "Default name, owo"
                    color: textColor
                    font.pixelSize: fontSize
                }
                Text {
                    id: realItem
                    text: "Default real name, owo"
                    color: textColor
                    font.pixelSize: fontSize
                }
                Text {
                    text: get_save_type(userid)
                    color: textColor
                    font.pixelSize: fontSize
                }
            }
        }
    }
}