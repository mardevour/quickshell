import QtQuick
import Quickshell.Services.SystemTray

import "../core"

Rectangle {
    id: root
    height: Theme.barHeight
    width: row.implicitWidth
    color: "transparent"

    Row {
        id: row
        Repeater {
            model: SystemTray.items
            delegate: Item {
                id: trayItem
                width: root.height
                height: root.height
                Rectangle {
                    anchors.centerIn: parent
                    width: Theme.barHeight - Theme.barElementMargin
                    height: Theme.barHeight - Theme.barElementMargin
                    radius: Theme.buttonRadius
                    color: mouseArea.containsMouse ? Theme.bgHover : "transparent"
                }
                Image {
                    source: modelData.icon
                    anchors.centerIn: parent
                    width: Theme.barTrayIconSize
                    height: Theme.barTrayIconSize
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            //console.log("Left click - hasMenu:", modelData.hasMenu, "id:", modelData.id)
                            modelData.activate();
                        }
                        if (mouse.button === Qt.RightButton && modelData.hasMenu) {
                            //console.log("Right click - hasMenu:", modelData.hasMenu, "id:", modelData.id)
                            modelData.display(bar, trayItem.mapToItem(bar.contentItem, mouseX, mouseY).x, trayItem.mapToItem(bar.contentItem, mouseX, mouseY).y);
                        }
                    }
                }
            }
        }
    }
}
