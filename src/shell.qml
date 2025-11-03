//@ pragma UseQApplication
import Quickshell
import QtQuick
import QtQml.Models

//import "core/services"
import "bar"
import "background"

ShellRoot {
    // instanciar una Bar{} en cada monitor
    Instantiator {
        model: Quickshell.screens
        delegate: Bar {
            screen: modelData
        }
    }
    Background {}
}
