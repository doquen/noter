import QtQuick 2.9
import QtQuick.Controls 2.2
import QlChannelSerial 1.0
import Ssh 1.0

ApplicationWindow {

    property bool echo: false

    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("NoTer")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Configuración")
                width: parent.width
                onClicked: {
                    stackView.push(config)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Utilidades")
                width: parent.width
                onClicked: {
                    stackView.push(util)
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id:stackView;
        anchors.fill: parent;
        initialItem: cons
    }

    QlChannelSerial {
        property bool openned: false
        id: serial
        onReadyReadSignal: {
            var msg = getl()
            cons.sendText(msg)
            dell()
        }
        onConnected: {
            openned = conn
        }
    }
    Ssh {
        id: ssh
    }

    Console{
        property string connected
        connected: serial.openned ? qsTr("Conectado") : qsTr("Desconectado")
        id: cons
        title: "Terminal - " + config.comboPuerto.currentText + ", "
               + config.comboBaudios.currentText + ", " + connected
        consmode: config.checkBoxConsola.checked
        hex: config.checkBoxHex.checked
        localEcho: config.checkBoxEcho.checked
    }
    Utilidades{
        id: util
        visible: false
    }

    Config {
        id: config
        visible: false
    }

    ToastManager{
        id: toast
    }
    Component.onCompleted: {
        ssh.writeData("ls\n")
    }
}


