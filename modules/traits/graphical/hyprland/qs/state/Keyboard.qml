pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string layout: "??"

    Process {
        id: devicesProc
        command: ["hyprctl", "devices", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const data = JSON.parse(this.text)
                const main = data.keyboards.find(k => k.main)
                if (main) {
                    root.layout = main.active_keymap.slice(0, 2).toLowerCase()
                }
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const parts = event.data.split(",")
                const layoutName = parts[parts.length - 1]
                root.layout = layoutName.slice(0, 2).toLowerCase()
            }
        }
    }
}
