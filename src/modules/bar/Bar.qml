import Quickshell
import QtQuick

import "../../core"

import "../../components/" as Components
import "../../components/buttons/" as Buttons
import "../../components/indicators/" as Indicators

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
            Buttons.Button {
                id: launcherButton
                icon: "󰣇"
                iconColor: Theme.accent
                command: "walker"
                iconSize: Theme.barLauncherIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Components.Separator {}
            Indicators.Workspace {}
            Components.Separator {}
            Indicators.FocusedWindow {}
        }

        Row {
            id: middle
            spacing: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Buttons.Button {
                id: test
                icon: ""
                iconColor: Theme.accent
                launchesWindow: true
                windowPath: "/home/mar/.config/quickshell/modules/settings/SettingsWindow.qml"
                iconSize: Theme.barCenterIconSize
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
            Indicators.Notification {
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Components.Separator {}
            Indicators.Date {
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
            Components.Separator {}
            Buttons.Button {
                id: controlCenterButton
                icon: ""
                iconColor: Theme.accent
                launchesWindow: true
                windowPath: "/home/mar/.config/quickshell/modules/controlCenter/ControlCenter.qml"
                iconSize: Theme.barCenterIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
