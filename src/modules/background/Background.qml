import QtQuick
import Quickshell
import Quickshell.Wayland

import "../../core"

Variants {
    id: root
    model: Quickshell.screens

    property string sourcePath: Theme.wallpaper

    PanelWindow {
        id: wallpaperWindow
        required property var modelData
        screen: modelData

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        Image {
            id: wallpaperImage
            source: root.sourcePath
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }
    }
}
