import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 
import SddmComponents

Item {
    id: root

    property int indexRp: 0
    property int selectedPage: 0

    TextConstants {
        id: textConstants
    }

    RowLayout {
        id: usersRow

        Repeater {
            model: Math.ceil( userModel.count / 3 )

            RowLayout {
                spacing: 10
                visible: selectedPage == usersRow.children.indexOf(this)
            }
        }


    }


    function addToRoot(username, realname) {
        indexRp = indexRp + 1
        var c = Qt.createComponent("NewGameUserInstance")
        c.createObject(
            usersRow.children[
                Math.ceil( indexRp / 3 )
            ],
            {
                username: username,
                realUsername: realname
            }
        )
    } 

    Repeater {
        id: mainRepeater
        
        model: userModel

        Text {
            text: model.name
        }

        delegate: Item {
            Component.onCompleted: {
                root.addToRoot(model.name, model.realName)
            }
        }
    }
}