import QtQuick

QtObject {
    function loadThemeByName(themeName) {
        const path = Qt.resolvedUrl(`../../themes/${themeName}.json`)
        return loadTheme(path)
    }

    function loadTheme(filePath) {
        const request = new XMLHttpRequest()
        request.open("GET", filePath)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                try {
                    const json = JSON.parse(request.responseText)
                    if (json.colors) {
                        theme.applyColors(json.colors)
                        //console.log("[ThemeHandler] theme loaded: ", filePath)
                    }
                } catch (e) {
                    //console.error("[ThemeHandler] error loading theme:", e)
                }
            }
        }
        request.send()
    }
}