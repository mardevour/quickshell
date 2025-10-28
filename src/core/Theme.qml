import QtQuick
pragma Singleton

import "services"

QtObject {
    id: theme
    property var themeHandler: ThemeHandler {
        themeSingleton: theme
    }
    property var configHandler: ConfigHandler {
        Component.onCompleted: {
            loadConfig()
        }
    }

    property string font: "Noto Sans Medium"

    // colors
    property string accent: "#a6d189"
    property string bg: '#0c0c1c'
    property string bgAlt: '#292c3c'
    property string bgTrans: '#de0c0c1c'
    property string bgAltTrans: '#de292c3c'
    property string bgHover: '#50020202'
    property string bgAltHover: '#de4f536b'
    property string fg: "#dce0e8"
    property string fgInactive: '#6d7586'
    property string border: "#626880"
    property string borderHover: "#a5adce"

    property string launcherIconColor: accent

    property string wallpaper: "/home/mar/Imágenes/fondos/walls-catppuccin-mocha/cabin.png"

    // sizes, margins, borders, etc
    // bar
    property int barHeight: 27
    property int barRadius: 7

    property int barElementMargin: 5
    property int barIconSize: 18
    property int barTrayIconSize: 17
    property int barCenterIconSize: 27
    property int barLauncherIconSize: 27
    property int barNotificationIconSize: 20

    property int barIFontSize: 14

    property int buttonRadius: 4

    // workspaces
    property string wsActive: accent
    property string wsInactive: '#4fc6d0f5'

    // separator
    property string separatorColor: '#75c6d0f5'
    property int separatorWidth: 2
    property int spacerTopBottomMargin: 11
    property int spacerSideMargin: 9

    // control center
    property int avatarSize: 75
    property int centerWindowPadding: 15
    property int centerWindowWidth: 400
    property int centerIconSize: 40
    property int centerControlsIconSize: 20

    // settings
    property int settingsIconSize: 40

    property string color0: "#c0caf5"
    property string color1: "#f7768e" 
    property string color2: "#9ece6a"
    property string color3: "#e0af68"
    property string color4: "#7aa2f7"
    property string color5: "#bb9af7"
    property string color6: "#7dcfff" 
    property string color7: "#a9b1d6"
    property string color8: "#565f89"
    property string color9: "#f7768e"
    property string color10: "#9ece6a"
    property string color11: "#e0af68"
    property string color12: "#7aa2f7"
    property string color13: "#bb9af7" 
    property string color14: "#7dcfff"
    property string color15: "#c0caf5"

    function applyColors(colors) {
        try {
            console.log("=== THEME.APPLYCOLORS INICIADO ===")
            console.log("[Theme] Colors recibidos:", JSON.stringify(colors))
            console.log("[Theme] colors.accent:", colors.accent)
            console.log("[Theme] Theme.accent antes:", accent)

            function resolve(v) {
                console.log("[Theme] Resolviendo:", v)
                if (v && colors[v]) {
                    console.log("[Theme] Resuelto a:", colors[v])
                    return colors[v];
                }
                console.log("[Theme] Usando valor directo:", v)
                return v;
            }

            console.log("[Theme] Asignando accent...")
            accent = resolve(colors.accent) || accent
            console.log("[Theme] Theme.accent después:", accent)
            
            console.log("[Theme] Asignando bg...")
            bg = colors.bg || bg
            console.log("[Theme] bg después:", bg)
            
            // Añade logs para TODAS las asignaciones
            console.log("[Theme] Asignando bgAlt...")
            bgAlt = colors.bg_alt || bgAlt
            console.log("[Theme] Asignando bgTrans...")
            bgTrans = colors.bg_trans || bgTrans
            console.log("[Theme] Asignando bgAltTrans...")
            bgAltTrans = colors.bg_alt_trans || bgAltTrans
            console.log("[Theme] Asignando bgHover...")
            bgHover = colors.bg_hover || bgHover
            console.log("[Theme] Asignando bgAltHover...")
            bgAltHover = colors.bg_alt_hover || bgAltHover
            console.log("[Theme] Asignando fg...")
            fg = colors.fg || fg
            console.log("[Theme] Asignando border...")
            border = colors.border || border
            console.log("[Theme] Asignando borderHover...")
            borderHover = colors.border_hover || borderHover
            console.log("[Theme] Asignando wsInactive...")
            wsInactive = colors.ws_inactive || wsInactive
            console.log("[Theme] Asignando separatorColor...")
            separatorColor = colors.separator || separatorColor

            // Asignar colores individuales
            console.log("[Theme] Asignando colores 0-15...")
            color0 = colors.color0 || color0
            color1 = colors.color1 || color1 
            color2 = colors.color2 || color2
            color3 = colors.color3 || color3
            color4 = colors.color4 || color4
            color5 = colors.color5 || color5
            color6 = colors.color6 || color6 
            color7 = colors.color7 || color7
            color8 = colors.color8 || color8
            color9 = colors.color9 || color9
            color10 = colors.color10 || color10
            color11 = colors.color11 || color11
            color12 = colors.color12 || color12
            color13 = colors.color13 || color13
            color14 = colors.color14 || color14
            color15 = colors.color15 || color15

            console.log("=== THEME.APPLYCOLORS COMPLETADO ===")
        } catch (error) {
            console.error("=== ERROR EN APPLYCOLORS ===")
            console.error("Error:", error)
            console.error("Stack:", error.stack)
            console.error("=== FIN ERROR ===")
        }
    }

    function loadTheme(filePath) {
        return themeHandler.loadTheme(filePath)
    }

    function loadThemeByName(themeName) {
        return themeHandler.loadThemeByName(themeName)
    }
}