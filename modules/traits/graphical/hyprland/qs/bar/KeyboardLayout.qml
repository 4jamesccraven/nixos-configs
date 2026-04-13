import Quickshell.Io
import "../state"
import "../widgets"

ShellButton {
    text: Keyboard.layout
    command: ["hyprctl", "switchxkblayout", "current", "next"]
}
