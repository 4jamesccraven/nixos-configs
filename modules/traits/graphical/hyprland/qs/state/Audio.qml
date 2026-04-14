pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root
    property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio.muted ?? false
    readonly property real volume: sink?.audio.volume ?? 0.0
    readonly property string volumeStr: String(Math.round(volume * 100)) + "%"
    readonly property string statusIcon: {
        if (root.muted) return ""
        if (root.volume <= 0.05) return ""
        if (root.volume <= 0.3) return ""
        return ""
    }

    function snap() {
        if (sink?.audio) sink.audio.volume = Math.round(sink.audio.volume * 20) / 20
    }

    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink?.audio.muted
    }

    function increment() {
        if (sink?.audio) {
            root.snap()
            sink.audio.volume = Math.min(1.2, sink?.audio.volume + 0.05)
        }
    }

    function decrement() {
        if (sink?.audio) {
            root.snap()
            sink.audio.volume = Math.max(0.0, sink?.audio.volume - 0.05)
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: root.snap()
    }

    PwObjectTracker {
        objects: [sink]
    }
}
