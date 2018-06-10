import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

Page {
    id: item1
    width: 400
    height: 400
    property alias switchHex: switchHex
    property alias comboBoxAppend: comboBoxAppend
    property alias textFieldConsole: textFieldConsole
    property alias buttonEnviar: buttonEnviar
    property alias clearButton: clearButton
    title: "Terminal"

    anchors.fill: parent
    property bool localEcho: false
    property bool consmode: false
    property bool hex: false
    //property alias scrollViewConsole: scrollViewConsole
    //property alias textAreaConsole: textAreaConsole
    property alias flowConsole: flowConsole

    RoundButton{
        id: clearButton
        icon.source: "limpiar.png"
        anchors.right: parent.right
        hoverEnabled: true
        opacity: hovered ? 1 : 0.2
        z:1
     }

    Flow {
        id: flowConsole
        y: 342
        spacing: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10


        TextField {
            id: textFieldConsole
            selectByMouse: true
            text: qsTr("")
            visible: !consmode
            height: consmode ? 0 : 46
            width: (flowConsole.width < 400) ? flowConsole.width :
                                               flowConsole.width -
                                               comboBoxAppend.width -
                                               switchHex.width -
                                               buttonEnviar.width -
                                               3*flowConsole.spacing


        }

        ComboBox {
            id: comboBoxAppend
            width: 95
            textRole: "text"
            visible: !consmode
            height: consmode ? 0 : 46
            model: ListModel {

                id: cbParItems
                ListElement { text: ""; value: "" }
                ListElement { text: "LF"; value: "\n" }
                ListElement { text: "CR"; value: "\r" }
                ListElement { text: "CR/LF"; value:"\r\n"}
            }
        }

        Switch {
            id: switchHex
            visible: !consmode
            height: consmode ? 0 : 46
            text: qsTr("HEX")
        }
        Button {
            id: buttonEnviar
            text: qsTr("Enviar")
            visible: !consmode
            height: consmode ? 0 : 48
        }
    }

}
