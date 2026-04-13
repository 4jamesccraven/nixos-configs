pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property bool micRecording: {
        const nodes = Pipewire.nodes.values
        return nodes.some(n =>
            n.type === PwNodeType.AudioInStream
        )
    }

    readonly property bool scrRecording: {
        const nodes = Pipewire.nodes.values
        return nodes.some(n =>
            n.properties["media.class"] === "Stream/Input/Video"
        )
    }

    PwObjectTracker {
        objects: Pipewire.nodes.values
    }
}
