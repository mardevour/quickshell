import QtQuick

import "../"

QtObject {
    function loadConfig() {
        const path = Qt.resolvedUrl("../../config.ini")
        const request = new XMLHttpRequest()
        request.open("GET", path)
        request.onreadystatechange = function() {
            if (request.readyState == XMLHttpRequest.DONE) {
                const text = request.responseText.trim()
                const lines = text.split("\n")
                const config = {}

                for (let i = 0; i < lines.length; i++) {
                    const line = lines[i].trim()
                    if (line.startsWith("#") || line === "") continue
                    const parts = line.split("=")
                    if (parts.length === 2) {
                        config[parts[0].trim()] = parts[1].trim()
                    }
                }

                if (config.theme) {
                    Theme.loadThemeByName(config.theme)
                    //console.log("[CongifHandler] loaded theme: ", config.theme)
                } else {
                    console.warn("[CongifHandler] no theme= found in config")
                }
            }
        }
        request.send()
    }
}