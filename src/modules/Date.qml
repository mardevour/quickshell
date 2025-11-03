import QtQuick
import Quickshell
import Quickshell.Io

import "../core"

Rectangle {
    id: date
    readonly property real horizontalPadding: 15

    width: dateArea.implicitWidth + horizontalPadding
    height: Theme.barHeight
    color: mouseArea.containsMouse ? Theme.bgHover : "transparent"
    radius: Theme.buttonRadius

    Row {
        id: dateArea
        spacing: 5
        anchors.centerIn: parent

        Text {
            id: dateText
            text: (systemClock?.date?.toLocaleDateString(Qt.locale(), "ddd, d"))
            font.family: Theme.font
            font.weight: Theme.fontWeight
            font.pixelSize: Theme.barIFontSize
            color: Theme.fg
            anchors.verticalCenter: parent.verticalCenter
            visible: true
        }
        Text {
            text: "·"
            font.family: Theme.font
            font.weight: Theme.fontWeight
            font.pixelSize: Theme.barIFontSize
            color: Theme.fg
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            id: timeText
            text: (systemClock?.date?.toLocaleTimeString(Qt.locale(), "HH:mm"))
            font.family: Theme.font
            font.weight: Theme.fontWeight
            font.pixelSize: Theme.barIFontSize
            color: Theme.fg
            anchors.verticalCenter: parent.verticalCenter
            visible: true
        }
    }

    SystemClock {
        id: systemClock
        precision: SystemClock.Minutes
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: process.running = true
        cursorShape: Qt.PointingHandCursor
    }

    Process {
        id: process
        command: ["notify-send", "-t", "3000", "To do...", ":P"]
        running: false
    }
}
