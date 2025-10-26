import QtQuick
import Quickshell

import "../../core"
import "../../core/services" as Services

Rectangle {
    id: root
    color: "transparent"
    height: Theme.barHeight
    width: windowTitleText.implicitWidth

    property string windowTitle: ""
    property var windows: []

    Services.NiriSocket {
        id: niriSocket

        onEvent: function(type, data) {
            //console.log("EVENTO:", type, "Data:", JSON.stringify(data).substring(0, 200) + "...")

            if (type === "WindowsChanged") {
                root.windows = data.windows || []
                root.updateFocusedWindowTitle()
                return
            }

            if (type === "WindowFocusChanged") {
                root.updateWindowFocus(data.id)
                root.updateFocusedWindowTitle()
                return
            }

            if (type === "WorkspaceActiveWindowChanged") {
                if (data.active_window_id) {
                    root.updateWindowFocus(data.active_window_id)
                    root.updateFocusedWindowTitle()
                }
                return
            }
        }
    }

    function updateWindowFocus(focusedWindowId) {
        for (let i = 0; i < root.windows.length; i++) {
            root.windows[i].is_focused = (root.windows[i].id === focusedWindowId)
        }
    }

    function updateFocusedWindowTitle() {
        if (!root.windows.length) {
            root.windowTitle = ""
            return
        }
        
        let focusedWindow = null
        for (let i = 0; i < root.windows.length; i++) {
            if (root.windows[i].is_focused) {
                focusedWindow = root.windows[i]
                break
            }
        }
        
        if (focusedWindow) {
            let newTitle = (focusedWindow.app_id || "unknown") + ": " + (focusedWindow.title || "")
            root.windowTitle = newTitle
        } else {
            root.windowTitle = ""
        }
    }

    Component.onCompleted: {
        niriSocket.send('"GetState"')
    }
    
    Text {
        text: {
            if (root.windowTitle.length > 40) {
                return root.windowTitle.substring(0, 37) + "..."
            }
            return root.windowTitle
        }
        id: windowTitleText
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

        color: Theme.fg
        font.family: "Noto Sans Medium"
        font.pixelSize: Theme.barIFontSize
        anchors.verticalCenter: parent.verticalCenter
    }
}