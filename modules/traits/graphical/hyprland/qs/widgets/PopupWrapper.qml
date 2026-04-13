import Quickshell
import Quickshell.Io
import QtQuick

import "../state"
import "../widgets"

PopupWindow {
    property var barWindow: null
    property int anchorY: barWindow ? barWindow.height : 0

    anchor.window: barWindow
    anchor.rect.x: barWindow ? barWindow.width : 0
    anchor.rect.y: anchorY

    implicitWidth: 480
    implicitHeight: 320
    color: "transparent"

    Rectangle {
        id: container
        anchors.fill: parent
        radius: 12
        color: Theme.base
        border.color: Theme.surface0
        border.width: 1

        default property alias content: container.data
    }
}

