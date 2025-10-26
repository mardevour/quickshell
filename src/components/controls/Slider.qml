import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import "../../core"
import "../../core/services"

Row {
    id: root
    // anchors.verticalCenter: parent.verticalCenter
    // anchors.fill: parent

    property real value
    property bool inactive

    property var onValueChangedCallback: function(newValue) {}

    Slider {
        id: slider
        width: parent.width
        height: 10
        anchors.verticalCenter: parent.verticalCenter

        value: root.value

        onValueChanged: {
            if (pressed) {
                root.onValueChangedCallback(value)
            }
        }

        background: Rectangle {
            width: parent.width
            height: 4
            anchors.verticalCenter: parent.verticalCenter
            radius: 2
            color: Theme.bgHover

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                radius: parent.radius
                color: inactive ? Theme.fgInactive : Theme.accent
            }
        }
        
        handle: Rectangle {
            id: volumeOutHandle
            width: 20
            height: 20
            radius: 10
            x: slider.visualPosition * (slider.availableWidth - width)
            color: inactive ? Theme.fgInactive : Theme.accent
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
