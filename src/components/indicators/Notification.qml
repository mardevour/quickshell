import QtQuick
import Quickshell.Io

import "../../core"

Rectangle {
    id: launcher
    height: Theme.barHeight
    width: 30
    color: mouseArea.containsMouse ? Theme.bgHover : "transparent"
    radius: Theme.buttonRadius

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: walker.running = true
        cursorShape: Qt.PointingHandCursor
    }

    Process {
        id: walker
        command: ["swaync-client", "-t"]
    }

    Text {
        text: ""
        anchors.centerIn: parent
        color: Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.barNotificationIconSize
    }
}
