import QtQuick
import QtQuick.Controls 

Item {
    id: root
    anchors.fill: parent

    default property alias content: windowsPlace.data
    property int focusedWindow: 0
    property int visibleWindows: 0
    property alias windows: windowsPlace.children

    onVisibleWindowsChanged: {
        if (visibleWindows >= 1) {
            windowsPlace.color = "#30000000"
        } else {
            windowsPlace.color = "#00000000"
        }
    }


    function changeFocus( elementInstance ) {
        const windowIndex = windows.indexOf( elementInstance )
        console.log("furtest: " + windowIndex)

        windowsPlace.children[focusedWindow].focused = false
        windowsPlace.children[windowIndex].focused = true

        focusedWindow = windowIndex
    }

    function showWindow(windowIndex) {
        windows[windowIndex].visible = true
        console.log("furtest show: ")
    }


    Rectangle {
        id: windowsPlace
        color: "#00000000"
        anchors.fill: parent
    }
}