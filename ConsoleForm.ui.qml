import QtQuick 2.4
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
    title: "Terminal"

    anchors.fill: parent
    property bool localEcho: false
    property bool consmode: false
    property bool hex: false
    property alias scrollViewConsole: scrollViewConsole
    property alias textAreaConsole: textAreaConsole

    ScrollView {
        id: scrollViewConsole
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: flowConsole.top
        anchors.bottomMargin: 10
        anchors.top: parent.top
        TextArea {
            id: textAreaConsole
            text: qsTr("")
            wrapMode: Text.WordWrap
            readOnly: true
        }
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

        TextEdit {
            id: textFieldConsole
            textFormat: TextEdit.RichText
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
