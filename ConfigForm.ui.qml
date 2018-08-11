import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

Page {
    id: page
    width: 700
    height: 700
    property alias textCustomPort: textCustomPort
    property alias checkBoxHex: checkBoxHex
    property alias checkBoxConsola: checkBoxConsola
    property alias checkBoxEcho: checkBoxEcho
    property alias label_port_pid: label_port_pid
    property alias label_port_vid: label_port_vid
    property alias label_port_ub: label_port_ub
    property alias label_port_ser: label_port_ser
    property alias label_port_fab: label_port_fab
    property alias label_port_desc: label_port_desc
    property alias comboPuerto: comboPuerto
    property alias comboFlujo: comboFlujo
    property alias comboPar: comboPar
    property alias comboStop: comboStop
    property alias comboBits: comboBits
    property alias comboBaudios: comboBaudios
    property alias okButton: okButton
    property alias flow1: flow1
    property alias scrollView: scrollView
    anchors.fill: parent
    title: qsTr("Configuración")

    ScrollView {
        id: scrollView
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 20
        width: parent.width - 20
        Flow {
            id: flow1
            spacing: 10
            width: scrollView.width

            GroupBox {
                id: groupBox
                width: (parent.width > 600) ? parent.width / 2 - parent.spacing : parent.width
                                              - parent.spacing
                height: 370
                title: qsTr("Puerto Serie:")

                Label {
                    id: label
                    text: qsTr("Puerto:")
                    anchors.verticalCenter: comboPuerto.verticalCenter
                }

                ComboBox {
                    id: comboPuerto
                    flat: false
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: label.right
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    editable: false
                }

                Label {
                    id: label_port_desc
                    text: qsTr("Descripción:")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: comboPuerto.bottom
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                    visible: comboPuerto.currentText !== qsTr("Otro")
                }

                Label {
                    id: label_port_fab
                    x: 4
                    text: qsTr("Fabricante:")
                    anchors.left: parent.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: label_port_desc.bottom
                    anchors.leftMargin: 5
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                    visible: comboPuerto.currentText !== qsTr("Otro")
                }

                Label {
                    id: label_port_ser
                    x: 9
                    text: qsTr("N° de Serie:")
                    anchors.left: parent.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: label_port_fab.bottom
                    anchors.leftMargin: 5
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                }

                Label {
                    id: label_port_ub
                    x: 16
                    y: -8
                    text: qsTr("Ubicacion:")
                    anchors.left: parent.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: label_port_ser.bottom
                    anchors.leftMargin: 5
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                }

                Label {
                    id: label_port_vid
                    x: 24
                    text: qsTr("VID:")
                    anchors.left: parent.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: label_port_ub.bottom
                    anchors.leftMargin: 5
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                }

                Label {
                    id: label_port_pid
                    x: 32
                    text: qsTr("PID:")
                    anchors.left: parent.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: label_port_vid.bottom
                    anchors.leftMargin: 5
                    anchors.topMargin: 15
                    elide: Text.ElideRight
                }

                CheckBox {
                    id: checkBoxEcho
                    text: qsTr("Eco")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                }

                CheckBox {
                    id: checkBoxConsola
                    x: 2
                    y: 0
                    text: qsTr("Modo Consola")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                }

                CheckBox {
                    id: checkBoxHex
                    y: -3
                    text: qsTr("Hex")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                }

                TextField {
                    id: textCustomPort
                    y: 68
                    text: qsTr("")
                    placeholderText: qsTr("Ingrese el puerto manualmente")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: comboPuerto.bottom
                    anchors.topMargin: 15
                    visible: comboPuerto.currentText === qsTr("Otro")
                }
            }

            GroupBox {
                id: groupBox1
                height: 370
                title: qsTr("Parámetros:")
                width: (parent.width > 600) ? parent.width / 2 - parent.spacing : parent.width
                                              - parent.spacing
                ComboBox {
                    id: comboBaudios
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: label5.right
                    anchors.leftMargin: 5
                    editable: true
                    model: ["9600", "19200", "38400", "115200"]
                    currentIndex: 3
                }

                Label {
                    id: label1
                    y: 20
                    text: qsTr("Baudios:")
                    anchors.verticalCenter: comboBaudios.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                Label {
                    id: label2
                    x: 1
                    y: 21
                    text: qsTr("Bits:")
                    anchors.verticalCenter: comboBits.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                ComboBox {
                    id: comboBits
                    y: 1
                    anchors.left: comboBaudios.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: comboBaudios.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    model: ["5", "6", "7", "8"]
                    currentIndex: 3
                }

                Label {
                    id: label3
                    x: -2
                    y: 18
                    text: qsTr("Paridad:")
                    anchors.verticalCenter: comboPar.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                ComboBox {
                    id: comboPar
                    anchors.left: comboBaudios.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: comboBits.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    textRole: "text"
                    model: ListModel {

                        id: cbParItems
                        ListElement {
                            text: qsTr("Ninguna")
                            value: "n"
                        }
                        ListElement {
                            text: qsTr("Par")
                            value: "e"
                        }
                        ListElement {
                            text: qsTr("Impar")
                            value: "o"
                        }
                        ListElement {
                            text: qsTr("Marca")
                            value: "m"
                        }
                        ListElement {
                            text: qsTr("Espacio")
                            value: "s"
                        }
                    }
                }

                Label {
                    id: label4
                    x: 6
                    y: 26
                    text: qsTr("Bits de Parada:")
                    anchors.verticalCenter: comboStop.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                ComboBox {
                    id: comboStop
                    anchors.left: comboBaudios.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: comboPar.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    model: ["1", "2"]
                }

                Label {
                    id: label5
                    x: 6
                    y: 26
                    text: qsTr("Control de Flujo:")
                    anchors.verticalCenter: comboFlujo.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                ComboBox {
                    id: comboFlujo
                    anchors.left: comboBaudios.left
                    anchors.rightMargin: 5
                    anchors.right: parent.right
                    anchors.top: comboStop.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 5
                    textRole: "text"
                    model: ListModel {
                        id: cbFlowItems
                        ListElement {
                            text: qsTr("Ninguno")
                            value: "n"
                        }
                        ListElement {
                            text: "RTS/CTS"
                            value: "r"
                        }
                        ListElement {
                            text: "XON/XOFF"
                            value: "x"
                        }
                    }
                }

                Button {
                    id: okButton
                    x: 268
                    text: qsTr("OK")
                    anchors.right: comboFlujo.right
                    anchors.rightMargin: 0
                    anchors.top: comboFlujo.bottom
                    anchors.topMargin: 10
                }
            }
        }
    }
}
