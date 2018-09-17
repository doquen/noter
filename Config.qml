import QtQuick 2.4

ConfigForm {

    Component.onCompleted: {
        var channels = serial.channels()
        channels.push(qsTr("Otro"))
        comboPuerto.model = channels
    }
    onVisibleChanged: {
        var channels = serial.channels()
        channels.push(qsTr("Otro"))
        comboPuerto.model = channels
    }

    comboPuerto.onCurrentIndexChanged: {
        updatePorts()
    }
    comboPuerto.onEditTextChanged: updatePorts()

    okButton.onPressed: {
        connectPort()
    }
    checkBoxEcho.onCheckStateChanged: {
        window.echo = checkBoxEcho.checked
    }
    function updatePorts(){
        var info = serial.channelInfo(comboPuerto.currentText)
        label_port_desc.text = qsTr("Descripción: ")+ info[0]
        label_port_fab.text = qsTr("Fabricante: ") + info[1]
        label_port_ser.text = qsTr("N° de Serie: ") + info[2]
        label_port_ub.text = qsTr("Ubicación: ") + info[3]
        label_port_vid.text = qsTr("VID: ") + info[4]
        label_port_pid.text = qsTr("PID: ") + info[5]
    }
    function connectPort(){
        if(serial.isOpen()){
            serial.close()
            if(!serial.isOpen()){
                okButton.text = qsTr("Conectar")
                toast.show(qsTr("Desconexión Exitosa"),2000,'green')
            }else{
                toast.show(qsTr("Error de Desconexión"),2000,'red')
            }
        }else{

            var channel = comboPuerto.currentText === qsTr("Otro") ?
                        textCustomPort.text : comboPuerto.currentText
            serial.open(channel)
            if(serial.isOpen()){
                serial.paramSet('baud',comboBaudios.currentText)
                serial.paramSet('bits',comboBits.currentText)
                serial.paramSet('flow',comboFlujo.model.get(comboFlujo.currentIndex).value)
                serial.paramSet('stops',comboStop.currentText)
                serial.paramSet('parity',comboPar.model.get(comboPar.currentIndex).value)
                toast.show(qsTr("Conexión Exitosa"),2000,'green')
                okButton.text = qsTr("Desconectar")
            }
            else{
                okButton.text = qsTr("Conectar")
                toast.show(qsTr("Error de Conexión"),2000,'red')
            }
        }
    }
}
