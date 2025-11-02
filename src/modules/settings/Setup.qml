import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../core"
import "../../components/buttons" as Buttons

WrapperRectangle {
    id: root
    color: Theme.bgTrans
    border.color: Theme.border
    border.width: 1
    radius: 0
    anchors.fill: parent

    GridLayout {
        id: grid
        columns: 4
        columnSpacing: 5
        rowSpacing: 5
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 10
        }

        Buttons.SettingsMiscButton {
            id: niriButton
            label: "Niri"
            icon: "file:///home/mar/.config/quickshell/assets/niri.svg"
            command: ["bash", "-c", "setsid kitty nvim /home/mar/.config/niri/config.kdl &"]
            settingsWindow: settingsMenu
            centerWindow: mainCenterWindow
        }
        Buttons.SettingsMiscButton {
            id: quickshellButton
            label: "Quickshell"
            icon: "file:///home/mar/.config/quickshell/assets/quickshell.svg"
            command: ["bash", "-c", "setsid zeditor /home/mar/.config/quickshell &"]
            settingsWindow: settingsMenu
            centerWindow: mainCenterWindow
        }
    }
}
