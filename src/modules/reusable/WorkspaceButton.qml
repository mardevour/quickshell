import QtQuick

import "../../core"
import "../../services"
import "../../modules/reusable"

Rectangle {
    id: root

    property bool isActive
    property string text

    color: isActive ? Theme.wsActive : Theme.wsInactive
    radius: 5
    width: isActive ? Theme.barHeight - 7 : Theme.barHeight - 11
    height: isActive ? Theme.barHeight - 7 : Theme.barHeight - 11
    anchors.verticalCenter: parent.verticalCenter

    property var onClickedCallback: null

    Text {
        text: root.isActive ? root.text : ""
        color: Theme.bg
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (onClickedCallback) {
                onClickedCallback();
            }
        }
    }
}
