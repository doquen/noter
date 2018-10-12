import QtQuick 2.4

ConfigForm {

    property string baudText: "115200"

    radioButtonSsh.onCheckedChanged: {
        if (radioButtonSsh.checked)
            checkBoxConsola.checked = true
    }

    comboBaudios.onEditTextChanged: {
        baudText = comboBaudios.editText
        console.log(baudText)
    }

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
    okSshButton.onPressed: {
        connectSsh()
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
                serial.paramSet('baud',baudText)
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
    function connectSsh(){
        if (!ssh.opened){
            ssh.paramSet("host",textFieldHostSsh.text)
            ssh.paramSet("user",textFieldUserSsh.text)
            ssh.paramSet("port",spinBoxPortSsh.value)
            ssh.setPassword(textFieldPassSsh.text)
            ssh.open()
            if(ssh.opened)
                toast.show(qsTr("Conexión Exitosa"),2000,'green')
            else
                toast.show(qsTr("Error de Conexión"),2000,'red')
        }
        else{
            ssh.close()
            if(!ssh.opened)
                toast.show(qsTr("Desconexión Exitosa"),2000,'green')
            else
                toast.show(qsTr("Error de Desonexión"),2000,'red')
        }
    }
}
