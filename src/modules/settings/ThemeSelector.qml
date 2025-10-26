import QtQuick
import QtQuick.Controls

Rectangle {
    width: 250
    height: 150
    color: Theme.bg
    border.color: Theme.border
    radius: 8

    Column {
        spacing: 10
        padding: 15

        Text {
            text: "Selector de Temas"
            color: Theme.fg
            font.bold: true
            font.pixelSize: 16
        }

        Button {
            text: "Tokyo Night Day"
            onClicked: Theme.loadThemeByName("tokyo-night-day")
            background: Rectangle {
                color: parent.down ? Theme.bgAlt : Theme.bgHover
                radius: 4
            }
        }

        Button {
            text: "Tema por Defecto"
            onClicked: {
                // Resetear a valores por defecto
                Theme.accent = "#a6d189";
                Theme.bg = '#0c0c1c';
                Theme.fg = "#dce0e8";
                // ... etc para todos los colores
            }
            background: Rectangle {
                color: parent.down ? Theme.bgAlt : Theme.bgHover
                radius: 4
            }
        }

        Text {
            text: "Tema actual: " + ThemeHandler.currentThemeName
            color: Theme.fg
            font.pixelSize: 12
        }
    }

    Connections {
        target: ThemeHandler
        function onThemeLoaded(themeName) {
            console.log("Tema cargado:", themeName);
        }
        
        function onThemeError(errorMsg) {
            console.error("Error de tema:", errorMsg);
        }
    }
}