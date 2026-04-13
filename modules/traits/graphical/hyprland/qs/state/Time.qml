pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string clockFace: {
        Qt.formatDateTime(clock.date, "hh\nmm")
    }
    readonly property string fullTime: {
        Qt.formatDateTime(clock.date, "ddd. MMM d, yyyy – hh:mm:ss")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
