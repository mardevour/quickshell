//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQml.Models

import "core"
import "core/services"
import "modules/bar"
import "modules/background"

ShellRoot {
	property var config: ConfigHandler {}

    Component.onCompleted: {
        config.loadConfig()
    }
    // instanciar una Bar{} en cada monitor
	Instantiator {
        model: Quickshell.screens
        delegate: Bar {
            screen: modelData
        }
    }
    Background {}
}