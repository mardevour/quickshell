pragma Singleton
import QtQuick

import "services"

QtObject {
    id: theme
    property var themeHandler: ThemeHandler {
        themeSingleton: theme
    }
    property var configHandler: ConfigHandler {
        Component.onCompleted: {
            loadConfig();
        }
    }

    property string font: "NotoSansM Nerd Font Mono"
    property int fontWeight: 500

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

    property string wallpaper: "/home/mar/Imágenes/fondos/walls-catppuccin-mocha/clouds-5.jpg"

    // sizes, margins, borders, etc
    // bar
    property int barHeight: 27
    property int barRadius: 7

    property int barElementMargin: 5
    property int barIconSize: 18
    property int barTrayIconSize: 17
    property int barCenterIconSize: 29
    property int barLauncherIconSize: 24
    property int barNotificationIconSize: 22

    property int barIFontSize: 15

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
            function resolve(v) {
                if (v && colors[v]) {
                    return colors[v];
                }
                return v;
            }
            accent = resolve(colors.accent) || accent;

            bg = colors.bg || bg;

            bgAlt = colors.bg_alt || bgAlt;
            bgTrans = colors.bg_trans || bgTrans;
            bgAltTrans = colors.bg_alt_trans || bgAltTrans;
            bgHover = colors.bg_hover || bgHover;
            bgAltHover = colors.bg_alt_hover || bgAltHover;
            fg = colors.fg || fg;
            border = colors.border || border;
            borderHover = colors.border_hover || borderHover;
            wsInactive = colors.ws_inactive || wsInactive;
            separatorColor = colors.separator || separatorColor;

            color0 = colors.color0 || color0;
            color1 = colors.color1 || color1;
            color2 = colors.color2 || color2;
            color3 = colors.color3 || color3;
            color4 = colors.color4 || color4;
            color5 = colors.color5 || color5;
            color6 = colors.color6 || color6;
            color7 = colors.color7 || color7;
            color8 = colors.color8 || color8;
            color9 = colors.color9 || color9;
            color10 = colors.color10 || color10;
            color11 = colors.color11 || color11;
            color12 = colors.color12 || color12;
            color13 = colors.color13 || color13;
            color14 = colors.color14 || color14;
            color15 = colors.color15 || color15;
        } catch (error) {
            console.error("[Theme]", error);
        }
    }

    function loadTheme(filePath) {
        return themeHandler.loadTheme(filePath);
    }

    function loadThemeByName(themeName) {
        return themeHandler.loadThemeByName(themeName);
    }
}
