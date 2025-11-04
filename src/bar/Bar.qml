import Quickshell
import QtQuick

import "../core"
import "../modules"
import "../modules/reusable"

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        top: 3
        left: 3
        right: 3
    }

    implicitHeight: Theme.barHeight
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.bgTrans
        radius: Theme.barRadius
        border.color: Theme.border
        border.width: 1

        Row {
            id: left
            spacing: 0
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.verticalCenter: parent.verticalCenter

            // launcher
            Button {
                id: launcherButton
                icon: "󰣇"
                iconColor: Theme.accent
                command: "walker"
                iconSize: Theme.barLauncherIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Separator {}
            Workspace {}
            Separator {}
            FocusedWindow {}
        }

        Row {
            id: middle
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            // debug settings button
            // Buttons.Button {
            //     id: test
            //     icon: ""
            //     iconColor: Theme.accent
            //     launchesWindow: true
            //     windowPath: "/home/mar/.config/quickshell/modules/settings/SettingsWindow.qml"
            //     iconSize: Theme.barIconSize
            //     height: Theme.barHeight - Theme.barElementMargin
            //     anchors.verticalCenter: parent.verticalCenter
            // }
            // debug reload button
            Button {
                id: reload
                icon: ""
                iconColor: Theme.accent
                launchesWindow: false
                command: "bash"
                commandArgs: ["-c", "nohup /home/mar/Devel/shell/src/init > /dev/null 2>&1 &"]
                iconSize: Theme.barIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: right
            spacing: 0
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter

            Systray {}
            Notification {
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Separator {}
            Date {
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Separator {}
            Button {
                id: controlCenterButton
                icon: ""
                iconColor: Theme.accent
                launchesWindow: true
                windowPath: "/home/mar/.config/quickshell/panels/controlCenter/ControlCenter.qml"
                iconSize: Theme.barCenterIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
