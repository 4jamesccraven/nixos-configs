import "../state"
import "../widgets"

ShellButton {
    visible: Battery.available

    icon: true
    text: Battery.statusIcon + "\n" + Battery.capacity + "%"
    textScale: 0.85
    color: (Battery.status === "Charging" | Battery.status === "Full") ? Theme.green
        : (Battery.capacity < 0.25) ? Theme.red
        : Theme.text
}
