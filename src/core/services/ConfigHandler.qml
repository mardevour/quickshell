import QtQuick
import Quickshell.Io

import "../"

Item {
    ThemeHandler { 
        id: themeHandler 
        themeSingleton: Theme
    }

    function loadConfig() {
        // console.log("[ConfigHandler] === INICIANDO LOADCONFIG ===")

        const path = Qt.resolvedUrl("../../config.ini")

        // console.log("[ConfigHandler] Ruta config.ini:", path)

        const request = new XMLHttpRequest()
        request.open("GET", path)
        request.onreadystatechange = function() {
            if (request.readyState == XMLHttpRequest.DONE) {

                // console.log("[ConfigHandler] XMLHttpRequest DONE")

                const text = request.responseText.trim()

                // console.log("[ConfigHandler] Contenido crudo de config.ini:")

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

                // console.log("[ConfigHandler] Config parseado:", JSON.stringify(config))
                // console.log("[ConfigHandler] theme encontrado:", config.theme)
                // console.log("[ConfigHandler] accent-color encontrado:", config["accent-color"])

                if (config.theme) {
                    if (config["accent-color"]) {
                        // console.log("[ConfigHandler] Llamando loadThemeByName con:", config.theme, config["accent-color"])
                        themeHandler.loadThemeByName(config.theme, config["accent-color"])
                    } else {
                        // console.log("[ConfigHandler] Llamando loadThemeByName con color por defecto")
                        themeHandler.loadThemeByName(config.theme, "color2")
                    }
                } else {
                    console.warn("[CongifHandler] no theme= found in config")
                }
                // console.log("[ConfigHandler] === FIN LOADCONFIG ===")
            }
        }
        request.send()
    }

    function saveOption(option, newValue) {
        const rutaAbsoluta = Qt.resolvedUrl("../../rustHelpers")
        const rutaFs = rutaAbsoluta.toString().replace(/^file:\/\//, "")
        saveProcess.workingDirectory = rutaFs
        saveProcess.command = ["bash", "-c", "./config_handler" + " " + option + " " + newValue]
        saveProcess.running = true
    }

    Process {
        id: saveProcess
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.log(this.text)
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.error("[ConfigHandler] " + this.text)
                }
            }
        }
    }
}