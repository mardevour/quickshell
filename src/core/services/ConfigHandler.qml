import QtQuick
import Quickshell.Io

import "../"

Item {
    ThemeHandler {
        id: themeHandler
        themeSingleton: Theme
    }

    function loadConfig() {
        const path = Qt.resolvedUrl("../../config.ini");
        const request = new XMLHttpRequest();
        request.open("GET", path);
        request.onreadystatechange = function () {
            if (request.readyState == XMLHttpRequest.DONE) {
                const text = request.responseText.trim();
                const lines = text.split("\n");
                const config = {};

                for (let i = 0; i < lines.length; i++) {
                    const line = lines[i].trim();
                    if (line.startsWith("#") || line === "")
                        continue;
                    const parts = line.split("=");
                    if (parts.length === 2) {
                        config[parts[0].trim()] = parts[1].trim();
                    }
                }
                if (config.theme) {
                    if (config["accent-color"]) {
                        themeHandler.loadThemeByName(config.theme, config["accent-color"]);
                    } else {
                        themeHandler.loadThemeByName(config.theme, "color2");
                    }
                } else {
                    console.warn("[CongifHandler] no theme= found in config");
                }
            }
        };
        request.send();
    }

    function saveOption(option, newValue) {
        const rutaAbsoluta = Qt.resolvedUrl("../../rustHelpers");
        const rutaFs = rutaAbsoluta.toString().replace(/^file:\/\//, "");
        saveProcess.workingDirectory = rutaFs;
        saveProcess.command = ["bash", "-c", "./config_handler" + " " + option + " " + newValue];
        saveProcess.running = true;
    }

    Process {
        id: saveProcess
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.log(this.text);
                }
            }
        }
        stderr: StdioCollector {
            onStreamFinished: {
                if (this.text !== "") {
                    console.error("[ConfigHandler] " + this.text);
                }
            }
        }
    }
}
