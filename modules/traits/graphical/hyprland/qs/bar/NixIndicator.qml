import Quickshell
import QtQuick

import "../state"
import "../widgets"

Item {
    width: parent.width
    height: mods.implicitHeight

    Pill {}
    Column {
        id: mods
        width: parent.width
        spacing: 0


        Item {
            id: days
            visible: false
            width: parent.width
            height: daysLabel.implicitHeight + 12

            Text {
                id: daysLabel
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 4
                horizontalAlignment: Text.AlignHCenter

                font.family: FontTheme.sans
                text: Nix.daysSinceUpdate + "d"
                font.pixelSize: Qt.application.font.pixelSize * 0.9
                color: (Nix.daysSinceUpdate > 21) ? Theme.red
                    : (Nix.daysSinceUpdate > 14) ? Theme.accent
                    : Theme.surface2
            }
        }

        Item {
            width: parent.width
            height: logo.implicitHeight

            Text {
                id: logo
                anchors.centerIn: parent

                text: ""
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                font.family: FontTheme.icon
                color: Theme.blue
            }

            MouseArea {
                id: mouseLogo
                anchors.fill: parent
                onClicked: days.visible = !days.visible
            }
        }

        Item {
            visible: Nix.outOfSync
            width: parent.width
            height: logo.implicitHeight

            Text {
                anchors.centerIn: parent

                text: "󰓦"
                font.pixelSize: Qt.application.font.pixelSize * 1.4
                font.family: FontTheme.icon
                color: Theme.accent
            }

            MouseArea {
                id: mouseSync
                anchors.fill: parent
                onClicked: Nix.outOfSync = false
            }
        }
    }
}
