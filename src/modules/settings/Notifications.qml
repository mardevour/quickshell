import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ScrollView {
        anchors.fill: parent
        clip: true
        
        ColumnLayout {
            width: parent.width
            spacing: 20
            
            Text {
                text: "Configuración de Notificaciones"
                font.bold: true
                font.pixelSize: 24
                Layout.bottomMargin: 20
            }
            
            GroupBox {
                title: "Tipos de Notificación"
                Layout.fillWidth: true
                
                ColumnLayout {
                    width: parent.width
                    
                    CheckBox {
                        text: "Notificaciones de sistema"
                        checked: true
                    }
                    
                    CheckBox {
                        text: "Notificaciones por email"
                        checked: false
                    }
                    
                    CheckBox {
                        text: "Notificaciones push"
                        checked: true
                    }
                }
            }
            
            GroupBox {
                title: "Sonidos"
                Layout.fillWidth: true
                
                ColumnLayout {
                    width: parent.width
                    
                    CheckBox {
                        text: "Reproducir sonido en notificaciones"
                        checked: true
                    }
                    
                    ComboBox {
                        Layout.fillWidth: true
                        model: ["Sonido predeterminado", "Campana", "Bip", "Ninguno"]
                        currentIndex: 0
                    }
                }
            }
            
            GroupBox {
                title: "Horario"
                Layout.fillWidth: true
                
                ColumnLayout {
                    width: parent.width
                    
                    RowLayout {
                        Text { text: "Modo No Molestar:" }
                        ComboBox {
                            Layout.fillWidth: true
                            model: ["Desactivado", "22:00 - 08:00", "Personalizado"]
                            currentIndex: 0
                        }
                    }
                }
            }
        }
    }
}