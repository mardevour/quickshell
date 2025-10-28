import QtQuick
import Quickshell
import Quickshell.Io

import "../../core"

Rectangle {
    id: root
    
    property var themeManager
    property string text: ""
    property string icon: ""
    property string iconColor: ""
    property string command: ""
    property var commandArgs: []
    property int iconSize: 20

    property bool launchesWindow
    property var window: null
    property var settingsComponent: null
    property string windowPath: ""
    
    width: 30
    color: mouseArea.containsMouse ? Theme.bgHover : "transparent"
    radius: Theme.buttonRadius

    property var onClickedCallback: null
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (onClickedCallback) {
                onClickedCallback()
            }
            // checks if launchesWindow is set to true
            // if true opens the window (windowPath qml file)
            // if false or null runs command
            if (launchesWindow) {
                if (window === null || window === undefined) {
                    settingsComponent = Qt.createComponent(windowPath)
                    if (settingsComponent.status === Component.Ready) {
                        window = settingsComponent.createObject(null)
                        window.visible = true
                    } else {
                        console.error("error al cargar", windowPath, ":", settingsComponent.errorString())
                    }
                } else {
                    window.visible = !window.visible
                }
            } else if (launchesWindow === false || launchesWindow === null) {
                if (command) {
                    processRunner.command = [command, ...commandArgs]
                    processRunner.running = true
                }
            }
        }
    }
    
    Process {
        id: processRunner
    }
    
    Text {
        id: textItem
        text: root.icon || root.text
        anchors.centerIn: parent
        color: root.iconColor
        font.family: "JetBrainsMono Nerd Font Mono"
        font.pixelSize: root.iconSize
    }
}