import Quickshell
import QtQuick
import QtQuick.Shapes

import "bar"

ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: Component {
            Bar {}
        }
    }
}
