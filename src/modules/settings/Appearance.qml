import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQml.Models

import "../../core"
import "../../core/services"

Rectangle {
    anchors.fill: parent
    color: "transparent"

    property var themesList
    property var accentColorIdx

    ThemeHandler {
        id: themeHandler
        themeSingleton: Theme
    }
    ConfigHandler {
        id: configHandler
    }

    property var themeSingleton: Theme

    Column {
        id: mainColumn
        spacing: 40
        anchors {
            left: parent.left
            leftMargin: 40
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 40
        }

        Row {
            id: lightDarkSettings
            spacing: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 120
                height: 100
                color: dayArea.containsMouse ? Theme.bgAltHover : Theme.bgAlt
                border.color: dayArea.containsMouse ? Theme.borderHover : Theme.border
                radius: Theme.buttonRadius + 2
                border.width: 1

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Text {
                        text: "󰖨"
                        color: Theme.fg
                        font.pixelSize: 36
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: "Modo día"
                        color: Theme.fg
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: dayArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                }
            }

            Rectangle {
                width: 120
                height: 100
                color: nightArea.containsMouse ? Theme.bgAltHover : Theme.bgAlt
                border.color: nightArea.containsMouse ? Theme.borderHover : Theme.border
                radius: Theme.buttonRadius + 2
                border.width: 1

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Text {
                        text: "󰽥"
                        color: Theme.fg
                        font.pixelSize: 36
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: "Modo noche"
                        color: Theme.fg
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    id: nightArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                }
            }
        }

        RowLayout {
            id: themeSelection
            anchors.left: parent.left
            anchors.right: parent.right

            ColumnLayout {
                Layout.alignment: Qt.AlignLeft
                Layout.preferredWidth: 250
                Layout.leftMargin: parent.width / 4.5
                spacing: 10

                Label {
                    text: "Tema para el modo claro"
                    color: Theme.fg
                    Layout.fillWidth: true
                    font.pixelSize: 14
                    font.family: Theme.font
                }
                Label {
                    text: "Tema para el modo oscuro"
                    color: Theme.fg
                    Layout.fillWidth: true
                    font.pixelSize: 14
                    font.family: Theme.font
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignRight
                Layout.fillWidth: true
                Layout.rightMargin: parent.width / 4.5
                spacing: 10

                ComboBox {
                    Layout.preferredWidth: 160
                    height: 30
                    model: themeHandler.themesList
                    currentIndex: 0
                    Layout.alignment: Qt.AlignRight
                }
                ComboBox {
                    Layout.preferredWidth: 160
                    height: 30
                    model: themeHandler.themesList
                    currentIndex: 0
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            Text {
                text: "Color de acento"
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.fg
                font.pixelSize: 14
                font.family: Theme.font
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                ListView {
                    id: accentColorList
                    orientation: ListView.Horizontal
                    width: contentWidth
                    height: 50
                    spacing: 8
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model: colorList

                    property int selectedIndex: -1

                    delegate: Rectangle {
                        id: colorButton
                        width: 50
                        height: 50
                        radius: Theme.buttonRadius
                        color: buttonColor
                        border.color: borderColor
                        border.width: 1

                        property bool selected: accentColorList.selectedIndex === index
                        property int colorIndex: index

                        Text {
                            anchors.centerIn: parent
                            text: selected ? "" : ""
                            color: Theme.bg
                            font.pixelSize: colorButton.width / 1.3
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                accentColorList.selectedIndex = index;
                                accentColorIdx = index;
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: applyButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.bottomMargin: 8
        color: applyArea.pressed ? Theme.bgAltHover : applyArea.containsMouse ? Theme.bgAltHover : Theme.bgAlt
        border.color: applyArea.containsMouse ? Theme.borderHover : Theme.border
        radius: Theme.buttonRadius + 2
        border.width: 1
        implicitWidth: rowContent.implicitWidth + 24
        implicitHeight: rowContent.implicitHeight + 16

        Row {
            id: rowContent
            anchors.centerIn: parent
            spacing: 8

            Text {
                text: ""
                color: Theme.fg
                font.pixelSize: 16
            }

            Text {
                text: "Aplicar"
                color: Theme.fg
                font.pixelSize: 14
            }
        }

        MouseArea {
            id: applyArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            // esto es absolutamente horrible y la unica forma q he conseguido hacer funcionar
            // para aplicar los cambios.........
            onClicked: {
                try {
                    if (accentColorIdx !== undefined && accentColorIdx !== null) {
                        let colorIdx = `color${accentColorIdx}`;

                        configHandler.saveOption("accent-color", colorIdx);
                        applyProcess.running = true;
                    } else {
                        console.warn("[Appearance] no hay color seleccionado");
                    }
                } catch (error) {
                    console.error("[Appearance]", error);
                }
            }
        }
        Process {
            id: applyProcess
            command: ["bash", "-c", "nohup /home/mar/Devel/shell/src/init > /dev/null 2>&1 &"]
        }
    }

    ListModel {
        id: colorList
    }

    Component.onCompleted: {
        themeHandler.loadThemesList();

        // hay que crear el ListModel colorList así porque no acepta variables dinámicas 🙃
        const colors = [
            {
                buttonColor: Theme.color0,
                borderColor: Theme.color8
            },
            {
                buttonColor: Theme.color1,
                borderColor: Theme.color9
            },
            {
                buttonColor: Theme.color2,
                borderColor: Theme.color10
            },
            {
                buttonColor: Theme.color3,
                borderColor: Theme.color11
            },
            {
                buttonColor: Theme.color4,
                borderColor: Theme.color12
            },
            {
                buttonColor: Theme.color5,
                borderColor: Theme.color13
            },
            {
                buttonColor: Theme.color6,
                borderColor: Theme.color14
            },
            {
                buttonColor: Theme.color7,
                borderColor: Theme.color15
            },
        ];
        for (let i = 0; i < colors.length; i++) {
            colorList.append(colors[i]);
        }
    }
}
