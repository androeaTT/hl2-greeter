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
        _breakEnabled = true
        _breakSegment = segment
        _breakFunc = onBreak
        console.log("OwO _breakEnabled: " + _breakEnabled + "; OwO _breakSegment: " + _breakSegment + "; OwO _breakSegment: " + _breakFunc )
    }

    function startLoading() {
        segmentTimer.running = true
    }

    function pause() {
        _paused = true
    }
    
    function unpause() {
        _paused = false
        rectTimer.restart()
    }

    progress: 0

    signal onLoaded()

    property int speed: 10
    property int segmentDelay: 500 
    property int segments: 4

    property bool _breakEnabled: false
    property int _breakSegment  
    property var _breakFunc
    property bool _paused: false

    Timer {
        id: segmentTimer

        property int count: 0

        interval: segmentDelay

        onTriggered: {
            if ( count >= segments ) {
                segmentTimer.running = false
            } else {
                if ( count == _breakSegment ) {
                    if (_breakEnabled) {
                        _breakFunc()
                    }
                }
                count ++
                if (!_paused) {
                    rectTimer.restart()
                }
            }
        }
    }

    Timer {
        id: rectTimer

        property int count: 0

        interval: speed

        onTriggered: {
            if ( 100 / segments * segmentTimer.count <= count) {
                segmentTimer.restart()
                rectTimer.running = false
            } else {
                progress++
                count++
                if (!_paused) {
                    rectTimer.restart()
                }
            }
        }
    }
}