//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick 2.15

import "core"
import "core/services"
import "modules/bar"
import "modules/background"

ShellRoot {
	property var config: ConfigHandler {}

    Component.onCompleted: {
        config.loadConfig()
    }
	
    Bar {}
    Background {}
}