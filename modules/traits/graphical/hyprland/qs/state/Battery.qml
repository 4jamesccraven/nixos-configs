pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool available: false
    property int capacity: 0
    property string status: "Unknown"

    readonly property string statusIcon: {
        if (root.status === "Charging" ||
            root.status === "Full")
        {
            if (capacity >= 90) return "󰂅";
            if (capacity >= 80) return "󰂋";
            if (capacity >= 70) return "󰂊";
            if (capacity >= 60) return "󰢞";
            if (capacity >= 50) return "󰂉";
            if (capacity >= 40) return "󰢝";
            if (capacity >= 30) return "󰂈";
            if (capacity >= 20) return "󰂇";
            if (capacity >= 10) return "󰂆";
            if (capacity >= 00) return "󰢜";
        } else {
            if (capacity >= 90) return "󰁹";
            if (capacity >= 80) return "󰂂";
            if (capacity >= 70) return "󰂁";
            if (capacity >= 60) return "󰂀";
            if (capacity >= 50) return "󰁿";
            if (capacity >= 40) return "󰁾";
            if (capacity >= 30) return "󰁽";
            if (capacity >= 20) return "󰁼";
            if (capacity >= 10) return "󰁻";
            if (capacity >= 00) return "󰁺";
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }

    Component.onCompleted: proc.running = true

    Process {
        id: proc
        command: ["bash", "-c", `
            for d in /sys/class/power_supply/*/; do
                [ "$(cat "$d/type" 2>/dev/null)" = "Battery" ] || continue
                [ -f "$d/capacity" ] || continue
                [ -f "$d/status" ] || continue
                echo "$(cat "$d/capacity"):$(cat "$d/status")"
                exit 0
            done
            echo "none"
        `]
        stdout: StdioCollector {
            onStreamFinished: {
                const out = this.text.trim()
                if (out === "none") {
                    root.available = false
                    return
                }
                const parts = out.split(":")
                root.available = true
                root.capacity = parseInt(parts[0]) || 0
                root.status = parts[1] ?? "Unknown"
            }
        }
    }
}
