import QtQuick

import "../core"
import "../services"
import "../modules/reusable"

Rectangle {
    id: root
    width: wsIndicator.implicitWidth
    height: Theme.barHeight
    color: "transparent"

    // TODO: pasarlo como propiedad externa al instanciar Workspace.qml
    property string barMonitor: "DVI-D-1"

    property var allWorkspaces: []
    property var currentMonitorWorkspaces: []
    property int currentWorkspaceId: -1

    NiriSocket {
        id: niriSocket

        onEvent: function (type, data) {
            if (type === "WorkspacesChanged") {
                if (data.workspaces) {
                    root.allWorkspaces = data.workspaces;
                    root.updateCurrentMonitorWorkspaces();
                }
                return;
            }

            if (type === "WorkspaceActivated") {
                if (data.id !== undefined) {
                    root.currentWorkspaceId = data.id;

                    var newWorkspaces = [];
                    for (var i = 0; i < root.allWorkspaces.length; i++) {
                        var ws = root.allWorkspaces[i];
                        newWorkspaces.push({
                            id: ws.id,
                            idx: ws.idx,
                            name: ws.name,
                            output: ws.output,
                            is_active: ws.id === data.id,
                            is_focused: ws.id === data.id ? data.focused : false,
                            active_window_id: ws.active_window_id,
                            is_urgent: ws.is_urgent
                        });
                    }
                    root.allWorkspaces = newWorkspaces;

                    root.updateCurrentMonitorWorkspaces();
                }
                return;
            }
        }

        onConnectionChanged: function (connected) {
            if (!connected) {
                root.allWorkspaces = [];
                root.currentMonitorWorkspaces = [];
                root.currentWorkspaceId = -1;
            }
        }
    }

    function updateCurrentMonitorWorkspaces() {
        if (!niriSocket.connected || !root.allWorkspaces.length) {
            root.currentMonitorWorkspaces = [];
            return;
        }

        var filtered = root.allWorkspaces.filter(function (ws) {
            return ws.output === root.barMonitor;
        });

        filtered.sort(function (a, b) {
            return a.idx - b.idx;
        });

        root.currentMonitorWorkspaces = filtered.slice();
    //console.log("Monitor", root.barMonitor, "→ workspaces actualizados:", JSON.stringify(root.currentMonitorWorkspaces))
    }

    Row {
        id: wsIndicator
        spacing: 3
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 5
        rightPadding: 5
        Repeater {
            model: root.currentMonitorWorkspaces
            delegate: WorkspaceButton {
                isActive: modelData.is_active || modelData.is_focused
                text: modelData.idx ? modelData.idx.toString() : "?"
                onClickedCallback: function () {
                    // console.log("niriSocket existe:", niriSocket !== undefined)
                    // console.log("niriSocket.connected:", niriSocket.connected)
                    // console.log("workspace id:", modelData.id, "index:", modelData.idx)
                    niriSocket.switchToWorkspace(modelData.idx);
                }
            }
        }
    }

    Component.onCompleted: {
        if (niriSocket.connected) {
            updateCurrentMonitorWorkspaces();
        }
    }
}
