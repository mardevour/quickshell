import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property string socketPath: Quickshell.env("NIRI_SOCKET") || ""
    property bool connected: false
    property var onEvent: null
    property var onConnectionChanged: null

    property int _reconnectAttempt: 0
    property int _reconnectBaseMs: 400
    property int _reconnectMaxMs: 15000

    Socket {
        id: socket
        path: root.socketPath

        parser: SplitParser {
            onRead: line => {
                try {
                    const event = JSON.parse(line);
                    if (root.onEvent) {
                        const eventType = Object.keys(event)[0];
                        root.onEvent(eventType, event[eventType]);
                    }
                } catch (e) {
                    console.warn("NiriSocket: Failed to parse event:", e);
                }
            }
        }

        onConnectionStateChanged: {
            root.connected = socket.connected;
            if (root.onConnectionChanged) {
                root.onConnectionChanged(root.connected);
            }

            if (socket.connected) {
                root._reconnectAttempt = 0;
                root.send('"EventStream"');
            } else if (root.connected) {
                root._scheduleReconnect();
            }
        }
    }

    Timer {
        id: reconnectTimer
        onTriggered: {
            socket.connected = false;
            Qt.callLater(() => socket.connected = true);
        }
    }

    function send(data) {
        if (!socket.connected)
            return false;

        const json = typeof data === "string" ? data : JSON.stringify(data);
        const message = json.endsWith("\n") ? json : json + "\n";
        socket.write(message);
        socket.flush();
        return true;
    }

    function ask(string) {
        if (!socket.connected)
            return false;

        const message = string;
        socket.write(message);
        socket.flush();
        return true;
    }

    function connect() {
        socket.connected = true;
    }

    function disconnect() {
        socket.connected = false;
        reconnectTimer.stop();
    }

    function _scheduleReconnect() {
        const pow = Math.min(_reconnectAttempt, 10);
        const base = Math.min(_reconnectBaseMs * Math.pow(2, pow), _reconnectMaxMs);
        const jitter = Math.floor(Math.random() * Math.floor(base / 4));
        reconnectTimer.interval = base + jitter;
        reconnectTimer.restart();
        _reconnectAttempt++;
    }

    function switchToWorkspace(workspaceIndex) {
        const tempSocket = Qt.createQmlObject(`
            import QtQuick
            import Quickshell.Io
            Socket {
                path: "${root.socketPath}"
                connected: true
            }
        `, root);

        const message = JSON.stringify({
            "Action": {
                "FocusWorkspace": {
                    "reference": {
                        "Index": workspaceIndex
                    }
                }
            }
        }) + "\n";
        tempSocket.write(message);
        tempSocket.flush();
        tempSocket.connected = false;
        tempSocket.destroy();
    }

    function getFocusedWindowTitle() {
        return send('"FocusedWindow"');
    }

    // function focusWindow(windowId) {
    //     return send({"Action": {"FocusWindow": {"id": windowId}}})
    // }

    // function toggleOverview() {
    //     return send({"Action": {"ToggleOverview": {}}})
    // }

    // function powerOffMonitors() {
    //     return send({"Action": {"PowerOffMonitors": {}}})
    // }

    // function powerOnMonitors() {
    //     return send({"Action": {"PowerOnMonitors": {}}})
    // }

    onSocketPathChanged: {
        if (socketPath && socketPath.length > 0) {
            connect();
        }
    }
}
