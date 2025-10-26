import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import "../../core"
import "../../core/services"
import "../../components/controls" as Controls

Rectangle {
    id: root
    Layout.fillWidth: true
    Layout.leftMargin: 7 
    Layout.rightMargin: 7
    height: 70
    radius: 8
    border.width: 1
    border.color: Theme.border
    color: "transparent"
    clip: true

    property string icon
    property string name
    property bool inactive
    property real value

    property var onValueChangedCallback: function(newValue) {}
    property var onToggleCallback: function() {}

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: header
            Layout.fillWidth: true
            height: 37
            color: (headerArea.containsMouse && !iconArea.containsMouse) ? Theme.bgHover : Theme.bgAltTrans
            border.width: 1
            border.color: Theme.border
            radius: root.radius
            clip: true

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 12
                anchors.topMargin: 5
                anchors.bottomMargin: 5

                Rectangle {
                    id: button
                    Layout.alignment: Qt.AlignVCenter
                    implicitWidth: 30
                    implicitHeight: iconButton.implicitHeight + 3
                    color: iconArea.containsMouse ? Theme.bgHover : "transparent"
                    radius: 5

                    Text {
                        anchors.centerIn: parent
                        id: iconButton
                        text: icon
                        color: inactive ? Theme.color1 : Theme.fg
                        font.bold: true
                        font.pixelSize: 17
                    }
                    MouseArea {
                        id: iconArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            root.onToggleCallback()
                        }
                    }
                }
                Text {
                    id: nameLabel
                    Layout.alignment: Qt.AlignVCenter
                    text: name
                    color: Theme.fg
                    font.bold: true
                }
                Item {
                    Layout.fillWidth: true
                }
                Text {
                    text: ""
                    color: Theme.fg
                    Layout.alignment: Qt.AlignVCenter
                }
            }
            MouseArea {
                id: headerArea
                anchors.top: header.top
                anchors.bottom: header.bottom
                anchors.left: header.left
                anchors.right: header.right
                anchors.leftMargin: button.width + parent.anchors.leftMargin + 12

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    console.log("Header clicked (excluding icon)")
                }
            }
        }

        // line separator
        // Rectangle {
        //     height: 1
        //     Layout.fillWidth: true
        //     color: Theme.border
        // }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.margins: 8
                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    spacing: 8

                    Text {
                        id: sliderTag
                        text: Math.round(root.value * 100) + "%"
                        color: Theme.fg
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Controls.Slider {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        value: root.value
                        inactive: root.inactive
                        onValueChangedCallback: root.onValueChangedCallback
                    }
                }
            }
        }
    }
}
