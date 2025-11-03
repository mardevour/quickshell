pragma Singleton
import QtQuick

import "../"

Item {
    id: theme
    Config {
        id: config
    }

    property string themeName: config.themeName

    Loader {
        id: themeLoader
        source: {
            switch (themeName) {
            case "Default":
                return "../themes/DefaultTheme.qml";
            case "TokyoNightDay":
                return "../themes/TokyoNightDay.qml";
            case "TokyoNightMoon":
                return "../themes/TokyoNightMoon.qml";
            default:
                return "../themes/DefaultTheme.qml";
            }
        }
    }

    // colors
    property color accent: config.accent
    property color bg: themeLoader.item.bg
    property color bgAlt: themeLoader.item.bgAlt
    property color bgTrans: themeLoader.item.bgTrans
    property color bgAltTrans: themeLoader.item.bgAltTrans
    property color bgHover: themeLoader.item.bgHover
    property color bgAltHover: themeLoader.item.bgAltHover
    property color fg: themeLoader.item.fg
    property color fgInactive: themeLoader.item.fgInactive
    property color border: themeLoader.item.border
    property color borderHover: themeLoader.item.borderHover
    property color launcherIconColor: themeLoader.item.launcherIconColor
    property color wsActive: themeLoader.item.wsActive
    property color wsInactive: themeLoader.item.wsInactive
    property color separatorColor: themeLoader.item.separator

    property color color0: themeLoader.item.color0  // black
    property color color1: themeLoader.item.color1  // red
    property color color2: themeLoader.item.color2  // green
    property color color3: themeLoader.item.color3  // yellow
    property color color4: themeLoader.item.color4  // blue
    property color color5: themeLoader.item.color5  // magenta
    property color color6: themeLoader.item.color6  // cyan
    property color color7: themeLoader.item.color7  // white
    property color color8: themeLoader.item.color8  // black
    property color color9: themeLoader.item.color9  // red
    property color color10: themeLoader.item.color10  // green
    property color color11: themeLoader.item.color11  // yellow
    property color color12: themeLoader.item.color12  // blue
    property color color13: themeLoader.item.color13  // magenta
    property color color14: themeLoader.item.color14  // cyan
    property color color15: themeLoader.item.color15  // white

    property string font: "NotoSansM Nerd Font Mono"
    property int fontWeight: 500

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

    // separator
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

    // function setTheme(name) {
    //     themeName = name
    // }
    Component.onCompleted: {
        console.log(config.themeName, config.accent);
    }
}
