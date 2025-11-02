import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets

import "../../core"

Rectangle {
    id: root
    color: mouseArea.containsMouse ? Theme.bgHover : Theme.bgAlt
    radius: 5
    width: 80
    height: 80
    border.color: Theme.border
    border.width: 1

    property string label
    property string icon
    property var command: []

    property var centerWindow
    property var settingsWindow

    Process {
        id: process
        command: root.command
    }

    ColumnLayout {
        id: column
        anchors.fill: parent
        IconImage {
            source: root.icon
            implicitSize: Theme.settingsIconSize
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: root.label
            color: Theme.fg
            Layout.alignment: Qt.AlignHCenter
            elide: Text.ElideRight
            Layout.preferredWidth: parent.width
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            process.startDetached();
            if (settingsWindow) {
                settingsWindow.destroy();
                centerWindow.destroy();
            }
        }
    }
}
