import QtQuick
import Qt.labs.folderlistmodel

import "../"

Item {
    id: themeHandler

    property var themesList: []
    property string themesPath: Qt.resolvedUrl("../../themes/")
    property var themeSingleton

    FolderListModel {
        id: folderModel
        folder: themeHandler.themesPath
        nameFilters: ["*.json"]
        showDirs: false
        onCountChanged: {
        if (count > 0)
            themeHandler.loadThemesList()
        }
    }

    function loadThemeByName(themeName, accentColor) {

        // console.log("[ThemeHandler] loadThemeByName llamado con:", themeName, accentColor)

        const path = Qt.resolvedUrl(`../../themes/${themeName}.json`)

        // console.log("[ThemeHandler] Ruta del tema:", path)

        return loadTheme(path, accentColor)
    }

    function loadTheme(filePath, accentColor) {

        console.log("[ThemeHandler] loadTheme llamado con:", filePath, accentColor)
        console.log("[ThemeHandler] Theme.applyColors exists:", typeof Theme.applyColors)

        const request = new XMLHttpRequest()
        request.open("GET", filePath)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {

                console.log("[ThemeHandler] Archivo de tema cargado")

                try {
                    const json = JSON.parse(request.responseText)

                    console.log("[ThemeHandler] JSON parseado, keys:", Object.keys(json))

                    if (json.colors) {

                        console.log("[ThemeHandler] Colors antes:", JSON.stringify(json.colors))

                        var newColors = {};
                        newColors.accent = accentColor;
                        
                        // Copiar todas las propiedades existentes
                        for (var key in json.colors) {
                            if (json.colors.hasOwnProperty(key)) {
                                newColors[key] = json.colors[key];
                            }
                        }
                        
                        json.colors = newColors;

                        console.log("[ThemeHandler] Colors después:", JSON.stringify(json.colors))
                        console.log("[ThemeHandler] Llamando Theme.applyColors...")

                        console.log("[ThemeHandler] typeof Theme.applyColors:", typeof Theme.applyColors)

                        // Theme.applyColors(json.colors)

                        // console.log("[ThemeHandler] applyColors completado")
                        if (themeSingleton && typeof themeSingleton.applyColors === "function") {
                            console.log("[ThemeHandler] Llamando themeSingleton.applyColors...")
                            themeSingleton.applyColors(json.colors)
                            console.log("[ThemeHandler] applyColors completado")
                        } else {
                            console.error("[ThemeHandler] themeSingleton no disponible o applyColors no es función")
                        }
                    }
                } catch (e) {
                    console.error("[ThemeHandler] error loading theme:", e)
                    console.error("[ThemeHandler] stack:", e.stack)
                }
            }
        }
        request.send()
    }

    function loadThemesList() {
        var themes = []
        for (var i = 0; i < folderModel.count; i++) {
            var file = folderModel.get(i, "fileName")
            if (file.endsWith(".json"))
                themes.push(file.replace(".json", ""))
        }
        themesList = themes
    }
}