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
        const path = Qt.resolvedUrl(`../../themes/${themeName}.json`)
        return loadTheme(path, accentColor)
    }

    function loadTheme(filePath, accentColor) {
        const request = new XMLHttpRequest()
        request.open("GET", filePath)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                try {
                    const json = JSON.parse(request.responseText)
                    if (json.colors) {

                        // nuevo objeto para añadir el color accent al principio
                        var newColors = {};
                        newColors.accent = accentColor;
                        for (var key in json.colors) {
                            if (json.colors.hasOwnProperty(key)) {
                                newColors[key] = json.colors[key];
                            }
                        }
                        json.colors = newColors;
                        themeSingleton.applyColors(json.colors)
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