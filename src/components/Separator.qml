import QtQuick

import "../core"

Rectangle {
    color: "transparent"
    height: Theme.barHeight
    width: line.implicitWidth + Theme.spacerSideMargin
    Rectangle {
        id: line
        color: Theme.separatorColor
        radius: Theme.separatorWidth
        anchors.centerIn: parent
        width: Theme.separatorWidth
        height: Theme.barHeight - Theme.spacerTopBottomMargin
    }
}