import Quickshell
import QtQuick

import "../state"
import "../widgets"

Item {
    width: parent.width
    height: mods.implicitHeight

    Pill{
        visible: Privacy.micRecording || Privacy.scrRecording
    }
    Column {
        id: mods
        width: parent.width
        spacing: 0

        // MIC INDICATOR
        Item {
            visible: Privacy.micRecording
            width: parent.width
            height: label.implicitHeight + 12

            Text {
                id: label

                anchors.centerIn: parent
                anchors.verticalCenterOffset: Privacy.scrRecording ? 4 : 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: ""
                font.family: FontTheme.icon
                color: Theme.accent
            }
        }

        // SCREENSHARE INDICATOR
        Item {
            width: parent.width
            height: parent.width - 10
            visible: Privacy.scrRecording

            Rectangle {
                id: outer
                anchors.centerIn: parent
                width: 16
                height: width
                radius: width / 2
                color: Theme.red
            }
            Rectangle {
                anchors.centerIn: outer
                width: 12
                height: width
                radius: width / 2
                border.color: Theme.mantle
                border.width: 1.2
                color: "transparent"
            }
        }
    }
}
