import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland

import "../../core"
import "../../core/services"

PanelWindow {
    id: powerMenu

    implicitWidth: 280
    implicitHeight: 300
    color: "transparent"

    WlrLayershell.keyboardFocus: WlrLayershell.OnDemand

    property int selectedIndex: 0
    property var options: ["lock", "logout", "reboot", "poweroff"]

    // load and apply config
    property var config: ConfigHandler {}
    Component.onCompleted: {
        config.loadConfig();
    }

    function executeAction(action) {
        powerMenu.visible = false;

        let process = Qt.createQmlObject('import Quickshell.Io; Process {}', powerMenu);

        switch (action) {
        case "lock":
            process.exec("swaylock");
            break;
        case "logout":
            process.exec(["niri", "msg", "action", "quit"]);
            break;
        case "reboot":
            process.exec(["systemctl", "reboot"]);
            break;
        case "poweroff":
            process.exec(["systemctl", "poweroff"]);
            break;
        }
    }

    Item {
        anchors.fill: parent
        Keys.onPressed: event => {
            switch (event.key) {
            case Qt.Key_Up:
                selectedIndex = (selectedIndex - 1 + options.length) % options.length;
                event.accepted = true;
                break;
            case Qt.Key_Down:
                selectedIndex = (selectedIndex + 1) % options.length;
                event.accepted = true;
                break;
            case Qt.Key_Return:
            case Qt.Key_Enter:
            case Qt.Key_Space:
                executeAction(options[selectedIndex]);
                event.accepted = true;
                break;
            case Qt.Key_Escape:
                powerMenu.destroy();
                event.accepted = true;
                break;

            // case Qt.Key_1:
            //     executeAction("lock")
            //     event.accepted = true
            //     break

            // case Qt.Key_2:
            //     executeAction("logout")
            //     event.accepted = true
            //     break

            // case Qt.Key_3:
            //     executeAction("reboot")
            //     event.accepted = true
            //     break

            // case Qt.Key_4:
            //     executeAction("poweroff")
            //     event.accepted = true
            //     break
            }
        }

        // Forzar focus cuando se abre
        Component.onCompleted: {
            forceActiveFocus();
            selectedIndex = 0;
        }
        WrapperRectangle {
            color: Theme.bgTrans
            border.color: Theme.border
            border.width: 1
            radius: 10
            anchors.fill: parent

            ColumnLayout {
                id: column
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: 10
                }

                // título
                Text {
                    text: "Sesión"
                    color: "white"
                    font.bold: true
                    font.family: Theme.font
                    font.weight: Theme.fontWeight
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 10
                }

                // bloquear
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: lockArea.containsMouse ? Theme.bgHover : "transparent"
                    border.color: lockArea.containsMouse ? Theme.borderHover : Theme.border
                    border.width: 1

                    Row {
                        anchors.centerIn: parent
                        spacing: 10

                        Text {
                            text: ""
                            color: "white"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Bloquear"
                            color: "white"
                            font.pixelSize: 14
                            font.family: Theme.font
                            font.weight: Theme.fontWeight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: lockArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: powerMenu.executeAction("lock")
                    }
                }

                // cerrar sesión
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: logoutArea.containsMouse ? Theme.bgHover : "transparent"
                    border.color: logoutArea.containsMouse ? Theme.borderHover : Theme.border
                    border.width: 1

                    Row {
                        anchors.centerIn: parent
                        spacing: 10

                        Text {
                            text: "󰅚"
                            color: "white"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Cerrar Sesión"
                            color: "white"
                            font.pixelSize: 14
                            font.family: Theme.font
                            font.weight: Theme.fontWeight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: logoutArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: powerMenu.executeAction("logout")
                    }
                }

                // reiniciar
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: rebootArea.containsMouse ? Theme.bgHover : "transparent"
                    border.color: rebootArea.containsMouse ? Theme.borderHover : Theme.border
                    border.width: 1

                    Row {
                        anchors.centerIn: parent
                        spacing: 10

                        Text {
                            text: "󰑓"
                            color: "#ffa500"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Reiniciar"
                            color: "#ffa500"
                            font.pixelSize: 14
                            font.family: Theme.font
                            font.weight: Theme.fontWeight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: rebootArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: powerMenu.executeAction("reboot")
                    }
                }

                // apagar
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: poweroffArea.containsMouse ? Theme.bgHover : "transparent"
                    border.color: poweroffArea.containsMouse ? Theme.borderHover : Theme.border
                    border.width: 1

                    Row {
                        anchors.centerIn: parent
                        spacing: 10

                        Text {
                            text: ""
                            color: "#ff4444"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "Apagar"
                            color: "#ff4444"
                            font.pixelSize: 14
                            font.family: Theme.font
                            font.weight: Theme.fontWeight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: poweroffArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: powerMenu.executeAction("poweroff")
                    }
                }

                // Separador
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#404040"
                    Layout.topMargin: 10
                    Layout.bottomMargin: 5
                }

                // Botón Cancelar
                Rectangle {
                    Layout.fillWidth: true
                    height: 35
                    radius: 6
                    color: cancelArea.containsMouse ? '#757575' : "#505050"

                    Text {
                        text: "Cancelar"
                        color: "white"
                        font.pixelSize: 14
                        font.family: Theme.font
                        font.weight: Theme.fontWeight
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: cancelArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: powerMenu.destroy()
                    }
                }
            }
        }
    }
}
