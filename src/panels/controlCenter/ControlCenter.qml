import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io

import "../../core"
import "../../services"
import "../../modules/reusable"
import "./" as Here

PanelWindow {
    id: mainCenterWindow

    implicitWidth: Theme.centerWindowWidth
    implicitHeight: wrapper.height

    exclusiveZone: 0
    anchors.right: true
    anchors.top: true
    margins.top: 3
    margins.right: 3

    color: "transparent"

    //WlrLayershell.keyboardFocus: WlrLayershell.OnDemand
    WlrLayershell.keyboardFocus: WlrLayershell.None

    property string username: ""
    property string uptime: ""
    property int controlIconPadding: 20

    WrapperRectangle {
        id: wrapper
        anchors.left: parent.left
        anchors.right: parent.right
        color: Theme.bgTrans
        border.color: Theme.border
        border.width: 1
        radius: 10

        ColumnLayout {
            id: column

            Process {
                running: true
                command: ["whoami"]
                stdout: StdioCollector {
                    onStreamFinished: mainCenterWindow.username = text.trim()
                }
            }
            Process {
                running: true
                command: ["uptime", "-p"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        // Extraer horas y minutos del texto
                        var totalMinutes = 0;

                        // Buscar días
                        var dayMatch = text.match(/(\d+) day/);
                        if (dayMatch) {
                            totalMinutes += parseInt(dayMatch[1]) * 24 * 60;
                        }

                        // Buscar horas
                        var hourMatch = text.match(/(\d+) hour/);
                        if (hourMatch) {
                            totalMinutes += parseInt(hourMatch[1]) * 60;
                        }

                        // Buscar minutos
                        var minuteMatch = text.match(/(\d+) minute/);
                        if (minuteMatch) {
                            totalMinutes += parseInt(minuteMatch[1]);
                        }

                        // Convertir a HH:mm
                        var hours = Math.floor(totalMinutes / 60);
                        var minutes = totalMinutes % 60;

                        // Formatear con ceros a la izquierda
                        var formattedUptime = ("0" + hours).slice(-2) + ":" + ("0" + minutes).slice(-2);
                        mainCenterWindow.uptime = formattedUptime;
                    }
                }
            }

            WrapperRectangle {
                id: header
                Layout.fillWidth: true
                color: "transparent"
                Layout.preferredHeight: pfp.height + Theme.centerWindowPadding * 2

                RowLayout {
                    id: headerLayout
                    anchors.fill: parent
                    anchors.margins: Theme.centerWindowPadding

                    ClippingWrapperRectangle {
                        border.color: Theme.bgHover
                        border.width: 1
                        radius: 10

                        Image {
                            id: pfp
                            sourceSize.width: 75
                            sourceSize.height: 75
                            source: "/var/lib/AccountsService/icons/mar"
                        }
                    }

                    ColumnLayout {
                        Layout.leftMargin: Theme.centerWindowPadding
                        spacing: 0

                        Row {
                            spacing: 5
                            Text {
                                text: ""
                                color: Theme.accent
                                font.pixelSize: 20
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: username
                                color: Theme.fg
                                font.pixelSize: 15
                                font.family: Theme.font
                                font.weight: Theme.fontWeight
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Row {
                            spacing: 5
                            Text {
                                text: "󰣇"
                                color: Theme.accent
                                font.pixelSize: 21
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "Arch Linux"
                                color: Theme.fg
                                font.pixelSize: 15
                                font.family: Theme.font
                                font.weight: Theme.fontWeight
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Row {
                            spacing: 5
                            Text {
                                text: ""
                                color: Theme.accent
                                font.pixelSize: 22
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "uptime " + uptime
                                color: Theme.fg
                                font.pixelSize: 15
                                font.family: Theme.font
                                font.weight: Theme.fontWeight
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    // spacer
                    Item {
                        Layout.fillWidth: true
                    }

                    Row {
                        id: headerButtons
                        Button {
                            id: powerButton
                            icon: "󰐥"
                            iconColor: Theme.fg
                            iconSize: Theme.centerIconSize
                            height: Theme.centerIconSize + 5
                            width: Theme.centerIconSize + 5

                            launchesWindow: true
                            windowPath: "/home/mar/.config/quickshell/panels/PowerModule.qml"

                            onClickedCallback: function () {
                                mainCenterWindow.visible = false;
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                id: controls
                Layout.bottomMargin: Theme.centerWindowPadding

                Here.SliderBox {
                    icon: AudioService.sink.audio.muted ? "" : ""
                    name: AudioService.sink.nickname
                    value: AudioService.volumeOut
                    inactive: AudioService.sink.audio.muted
                    command: ["bash", "-c", "pavucontrol -t 3"]

                    onValueChangedCallback: function (newValue) {
                        if (AudioService.sink) {
                            AudioService.sink.audio.volume = newValue;
                        }
                    }

                    onToggleCallback: function () {
                        AudioService.sink.audio.muted = !AudioService.sink.audio.muted;
                    }

                    onHeaderClickedCallback: function () {
                        mainCenterWindow.visible = false;
                    }
                }
                Here.SliderBox {
                    icon: AudioService.source.audio.muted ? "" : ""
                    name: AudioService.source.nickname
                    value: AudioService.volumeIn
                    inactive: AudioService.source.audio.muted
                    command: ["bash", "-c", "pavucontrol -t 4"]

                    onValueChangedCallback: function (newValue) {
                        if (AudioService.source) {
                            AudioService.source.audio.volume = newValue;
                        }
                    }

                    onToggleCallback: function () {
                        AudioService.source.audio.muted = !AudioService.source.audio.muted;
                    }

                    onHeaderClickedCallback: function () {
                        mainCenterWindow.visible = false;
                    }
                }
            }
            GridLayout {
                columns: 2
                columnSpacing: 5
                rowSpacing: 5
                // anchors.horizontalCenter: parent.horizontalCenter
                // anchors.bottomMargin: 5
                Layout.topMargin: Theme.centerWindowPadding / 2
                Layout.bottomMargin: Theme.centerWindowPadding
                Layout.leftMargin: Theme.centerWindowPadding
                Layout.rightMargin: Theme.centerWindowPadding
                Layout.alignment: Qt.AlignHCenter

                Here.Toggle {
                    icons: ["", ""]
                    tag: ["Modo día", "Modo noche"]
                }
                Here.Toggle {
                    icons: ["", ""]
                    tag: ["Modo día", "Modo noche"]
                }
            }
        }
    }
}
