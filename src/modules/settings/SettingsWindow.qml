import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../core"
import "../../core/services"

Window {
    id: settingsMenu

    width: 500
    height: 500
    minimumWidth: 850
    color: Theme.bg

    // flags para hacer la ventana gestionable por el compositor
    flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowSystemMenuHint | Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint

    property var centerWindow
    property string waylandAppId: "settings-dialog"
    property bool isDialog: true
    property bool isFloating: true

    // cargar y aplicar config
    property var config: ConfigHandler {}
    Component.onCompleted: {
        config.loadConfig();
    }

    Item {
        anchors.fill: parent
        Keys.onPressed: event => {
            switch (event.key) {
            case Qt.Key_Escape:
                settingsMenu.destroy();
                event.accepted = true;
                break;
            }
        }

        Component.onCompleted: {
            forceActiveFocus();
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.bgTrans

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // sidebar
                Rectangle {
                    id: sidebar
                    Layout.minimumWidth: 150
                    Layout.maximumWidth: 220
                    Layout.fillHeight: true
                    color: Theme.bgAlt
                    layer.enabled: true
                    layer.smooth: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        Item {
                            Layout.preferredHeight: 80
                            Layout.fillWidth: true

                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Configuración [WIP]")
                                color: Theme.fg
                                font.pixelSize: 15
                                font.family: Theme.font
                            }
                        }

                        // Lista de elementos del menú
                        ListView {
                            id: menuList
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: menuModel
                            delegate: menuDelegate
                            clip: true
                            currentIndex: 0
                            spacing: 5

                            // no tengo claro q hace esto pero parece mejorar el rendimiento
                            boundsBehavior: Flickable.StopAtBounds
                            maximumFlickVelocity: 2000

                            ScrollIndicator.vertical: ScrollIndicator {
                                id: scrollIndicator
                                active: menuList.moving
                            }
                        }
                    }
                }

                // Separador
                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.fillHeight: true
                    color: Theme.border
                }

                Rectangle {
                    id: contentArea
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"
                    clip: true

                    Loader {
                        id: contentLoader
                        anchors.fill: parent
                        anchors.margins: 0
                        source: menuList.currentIndex >= 0 ? menuModel.get(menuList.currentIndex).page : ""
                        asynchronous: true
                        onLoaded: {
                            if (item) {
                                item.forceActiveFocus();
                            }
                        }
                    }
                }
            }
        }

        ListModel {
            id: menuModel
            ListElement {
                name: "Apariencia"
                icon: "󰔃"
                page: "Appearance.qml"
            }
            ListElement {
                name: "Notificaciones"
                icon: ""
                page: "Notifications.qml"
            }
            ListElement {
                name: "Entorno"
                icon: ""
                page: "Setup.qml"
            }
        }

        Component {
            id: menuDelegate

            Rectangle {
                id: menuItem
                width: parent.width
                height: 70
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 8
                }
                color: menuItemArea.containsMouse ? Theme.bgAltHover : (menuList.currentIndex == index ? Theme.bgAltHover : Theme.bgAlt)
                border.color: menuItemArea.containsMouse ? Theme.borderHover : (menuList.currentIndex == index ? Theme.borderHover : "transparent")
                radius: Theme.buttonRadius + 2

                MouseArea {
                    id: menuItemArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        menuList.currentIndex = index;
                    }
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: icon
                        font.pixelSize: 24
                        font.family: "Noto Sans Medium"
                        color: Theme.fg
                        renderType: Text.NativeRendering
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: name
                        color: Theme.fg
                        font.pixelSize: 12
                        font.family: "Noto Sans Medium"
                        renderType: Text.NativeRendering
                    }
                }
            }
        }

        // botón x
        Rectangle {
            id: closeButton
            width: 30
            height: 30
            radius: Theme.buttonRadius
            color: cancelArea.containsMouse ? Theme.bgHover : "transparent"

            anchors {
                top: parent.top
                right: parent.right
                margins: 5
            }

            Text {
                text: ""
                color: Theme.fg
                font.pixelSize: 16
                font.bold: true
                anchors.centerIn: parent
            }

            MouseArea {
                id: cancelArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: settingsMenu.destroy()
            }
        }
    }
}
