import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import "../state"
import "../widgets"

ShellButton {
    icon: true
    text: Audio.statusIcon + "\n" + (Audio.muted ? "-" : Audio.volumeStr)
    textScale: 0.85

    color: (Audio.muted || Audio.volume > 1.0) ? Theme.red
        : Theme.text

    onClicked: Audio.toggleMute()
    rightClickable: true
    rightCommand: ["pavucontrol"]

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: (wheel) => {
            wheel.angleDelta.y > 0 ? Audio.increment() : Audio.decrement()
        }
    }
}
