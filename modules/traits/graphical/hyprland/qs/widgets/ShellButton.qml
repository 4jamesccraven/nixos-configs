import Quickshell.Io
import QtQuick

import "../state"
import "../widgets"

Item {
    property alias text: label.text
    property alias color: label.color
    property real textScale: 1.2
    property bool accented: false
    property bool icon: false
    property bool mono: false
    property bool rightClickable: false

    property var command: []
    property var rightCommand: []
    signal clicked()

    implicitWidth: parent.width
    implicitHeight: label.implicitHeight + 10

    Process {
        id: proc
    }


    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5

        color: mouseArea.containsMouse ? Theme.crust : Theme.mantle
        radius: 15

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter

        font.family: icon ? FontTheme.icon
            : mono ? FontTheme.mono
            : FontTheme.sans
        font.pixelSize: Qt.application.font.pixelSize * textScale
        color: accented ? Theme.accent
            : mouseArea.containsMouse ? Theme.accent
            : Theme.text


        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        acceptedButtons: rightClickable ? Qt.LeftButton | Qt.RightButton : Qt.LeftButton
        hoverEnabled: true
        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                if (parent.rightCommand.length > 0) {
                    proc.command = parent.rightCommand
                    proc.startDetached()
                }
            } else {
                parent.clicked()
                if (parent.command.length > 0) {
                    proc.command = parent.command
                    proc.startDetached()
                }
            }
        }
    }
}
