import Quickshell
import QtQuick
import QtQuick.Layouts

import "../../core"

import "../../components/" as Components
import "../../components/buttons/" as Buttons
import "../../components/indicators/" as Indicators

PanelWindow {
    id: bar
    screen: {
        var monitors = Quickshell.screens;
        for (var i = 0; i < monitors.length; i++) {
            if (monitors[i].name === "DVI-D-1") {
                return monitors[i]
            }
        }
        return monitors[0]
    }
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
                windowPath: "/home/mar/.config/quickshell/modules/ControlCenter/ControlCenter.qml"
                iconSize: Theme.barCenterIconSize
                height: Theme.barHeight - Theme.barElementMargin
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
