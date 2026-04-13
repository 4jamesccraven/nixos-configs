import Quickshell.Io
import QtQuick
import "../state"
import "../widgets"

ShellButton {
    icon: true
    text: {
        if (Network.ethernetConnected) return "󰈀"
        if (Network.connected) return "󰖩"
        if (!Network.wifiEnabled) return "󰖪"
        return "󰖪"
    }
    accented: Network.ethernetConnected || Network.connected
    onClicked: {
        Network.refreshNetworks()
    }
}
