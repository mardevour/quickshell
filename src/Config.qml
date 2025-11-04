import QtQuick

Item {
    // alternar entre modo oscuro y modo claro
    property bool darkMode: false
    // selecciona el tema aquí
    // si quieres añadir un tema puedes añadir un `case` en el themeLoader
    // tema claro
    property string themeLight: "TokyoNightDay"
    // tema oscuro
    property string themeDark: "TokyoNightMoon"

    // selecciona el color de acento aquí
    // puedes elegir un color de la paleta `color1`, `color2`...
    // o poner un color personalizado `"#ff5555"`
    property color accent: color4

    // ruta del fondo de pantalla aquí
    property string wall: "/home/mar/Imágenes/fondos/walls-catppuccin-mocha/c4-spring-sakura-sky.jpg"
}
