// Theme for SDDM with Half-Life 2 GUI style
// Copyright (C) 2025  androeaTT
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
    property bool focused: false 
    signal changeFocus()

    property string textColor: focused ? "#ff9c00" : "#ccc"
    property int fontSize: 11

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

                color: focused ? "#ff9c00" : "#000"

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
                spacing: 5

                Rectangle { // spacer
                    color: "transparent"
                    height: 1
                    width: 1
                }

                Text {
                    id: nameItem

                    text: "Default name, owo"
                    color: textColor

                    font.weight: 800
                    font.family: "DejaVu Sans"
                    font.pixelSize: fontSize
                }
                Text {
                    id: realItem

                    text: "Default real name, owo"
                    color: textColor

                    font.weight: 100
                    font.family: "DejaVu Sans"
                    font.pixelSize: fontSize
                }
                Text {
                    text: get_save_type(userid)
                    color: textColor

                    font.weight: 100
                    font.family: "DejaVu Sans"
                    font.pixelSize: fontSize
                }
            }
        }
    }

    MouseArea {
        id: area
        
        anchors.fill: parent

        onClicked: { changeFocus() }
    }
}