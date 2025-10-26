import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io

import "../../core"
import "../../core/services"
import "../../components/buttons" as Buttons

PanelWindow {
    id: settingsMenu
    
    implicitWidth: 280
    implicitHeight: 300
    color: "transparent"

    WlrLayershell.keyboardFocus: WlrLayershell.OnDemand

    property var centerWindow

    // load and apply config
    property var config: ConfigHandler {}
    Component.onCompleted: {
        config.loadConfig()
    }

    Item {
    anchors.fill: parent
    Keys.onPressed: (event) => {
        switch(event.key) {
            case Qt.Key_Escape:
                settingsMenu.destroy()
                event.accepted = true
                break
        }
    }
    
    Component.onCompleted: {
        forceActiveFocus()
    }

    WrapperRectangle {
        id: background
        color: Theme.bgTrans
        border.color: Theme.border
        border.width: 1
        radius: 10
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
                command: ["bash", "-c", "setsid codium /home/mar/.config/quickshell &"]
                settingsWindow: settingsMenu
                centerWindow: mainCenterWindow
            }
        }
    }

    // botón x
    Rectangle {
        id: closeButton
        width: 35
        height: 35
        radius: 6
        color: cancelArea.containsMouse ? Theme.bgHover : "transparent"
        
        anchors {
            top: parent.top
            right: parent.right
            margins: 5
        }

        Text {
            text: ""
            color: Theme.fg
            font.pixelSize: 16
            font.bold: true
            anchors.centerIn: parent
        }
        
        MouseArea {
            id: cancelArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: settingsMenu.destroy()
        }
    }
}
}