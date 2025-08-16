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


SourceProgressBar {
    id: root

    function setBreak( segment, onBreak ) {
        breakEnabled = true
        breakSegment = segment
        breakFunc = onBreak
    }

    function startLoading() {
        segmentTimer.running = true
    }

    progress: 0
    visible: false

    signal onLoaded()

    property int speed: 10
    property int segmentDelay: 500 
    property int segments: 4

    property bool breakEnabled: false
    property int breakSegment: 0    
    function breakFunc() {}

    Timer {
        id: segmentTimer

        property int count: 0

        interval: segmentDelay

        onTriggered: {
            if ( count >= segments ) {
                console.log('OwO end: ' + count)
                segmentTimer.running = false
            } else {
                if ( count == breakSegment ) {
                    if (breakEnabled) {
                        breakFunc()
                    }
                }
                count ++
                rectTimer.restart()
                segmentTimer.restart()
            }
        }
    }
    Timer {
        id: rectTimer

        property int count: 0

        interval: speed

        onTriggered: {
            if ( 100 / segments * segmentTimer.count <= count) {
                rectTimer.running = false
            } else {
                progress++
                count++
                rectTimer.restart()
            }
        }
    }
}