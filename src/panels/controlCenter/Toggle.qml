import QtQuick
import Quickshell.Io

import "../../core"

Rectangle {
    id: root
    property var icons: []
    property var tag: []
    property bool isToggleOn

    radius: Theme.buttonRadius
    color: isToggleOn ? Theme.accent : (mouseArea.containsMouse ? Theme.bgAltHover : Theme.bgAlt)
    border.color: Theme.border
    border.width: 1
    implicitWidth: 140
    implicitHeight: 40

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }
    Behavior on border.color {
        ColorAnimation {
            duration: 200
        }
    }

    Row {
        spacing: 5
        anchors.centerIn: parent

        Text {
            text: isToggleOn ? (icons[1] || "") : (icons[0] || "")
            color: Theme.fg
        }
        Text {
            text: isToggleOn ? (tag[1] || "") : (tag[0] || "")
            font.family: Theme.font
            color: Theme.fg
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (root.isToggleOn) {
                root.isToggleOn = false;
                process.command = ["bash", "-c", "gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"];
                process.running = true;
                Theme.darkMode = false;
            } else if (!root.isToggleOn) {
                root.isToggleOn = true;
                process.command = ["bash", "-c", "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"];
                process.running = true;
                Theme.darkMode = true;
            }
        }
    }
    Process {
        id: process
    }
}
