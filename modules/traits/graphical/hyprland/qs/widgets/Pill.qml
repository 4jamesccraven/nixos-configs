import QtQuick

import "../state"

Rectangle {
    anchors.fill: parent
    anchors.leftMargin: 5
    anchors.rightMargin: 5

    color: mouseArea.containsMouse ? Theme.crust : Theme.mantle
    radius: 15

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
