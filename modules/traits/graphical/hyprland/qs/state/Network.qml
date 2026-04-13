pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool connected: false
    property bool ethernetConnected: false
    property var networks: []
    property var savedNetworks: []
    property string ssid: ""
    property int signal: 0

    function refresh() {
        statusProc.running = true
        ethernetProc.running = true
    }

    function refreshNetworks() {
        scanProc.running = true
        savedProc.running = true
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: {
        root.refresh()
        root.refreshNetworks()
    }

    Process {
        id: statusProc
        command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL,SECURITY", "dev", "wifi"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.connected = false
                root.ssid = ""
                root.signal = 0
                for (const line of this.text.trim().split("\n")) {
                    const parts = line.split(":")
                    if (parts[0] === "yes") {
                        root.connected = true
                        root.ssid = parts[1]
                        root.signal = parseInt(parts[2]) || 0
                        break
                    }
                }
            }
        }
    }

    Process {
        id: ethernetProc
        command: ["nmcli", "-t", "-f", "TYPE,STATE", "dev"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.ethernetConnected = false
                for (const line of this.text.trim().split("\n")) {
                    if (!line) continue
                    const parts = line.split(":")
                    if (parts[0] === "ethernet" && parts[1] === "connected") {
                        root.ethernetConnected = true
                        break
                    }
                }
            }
        }
    }

    Process {
        id: scanProc
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY,IN-USE", "dev", "wifi", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                const seen = {}
                for (const line of this.text.trim().split("\n")) {
                    if (!line) continue
                    const parts = line.split(":")
                    const ssid = parts[0]
                    if (!ssid) continue
                    const signal = parseInt(parts[1]) || 0
                    const security = parts[2]
                    const active = parts[3] === "*"
                    if (!seen[ssid] || signal > seen[ssid].signal) {
                        seen[ssid] = { ssid, signal, security, active }
                    }
                    if (active) seen[ssid].active = true
                }
                root.networks = Object.values(seen)
            }
        }
    }

    Process {
        id: savedProc
        command: ["nmcli", "-t", "-f", "NAME", "con", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.savedNetworks = this.text.trim().split("\n").filter(s => s.length > 0)
            }
        }
    }
}
