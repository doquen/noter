import QtQuick 2.4

ConfigForm {

    Component.onCompleted: {
        comboPuerto.model = serial.channels()
    }
    onVisibleChanged: {
        comboPuerto.model = serial.channels()
    }

    comboPuerto.onCurrentIndexChanged: {
        updatePorts()
    }

    okButton.onPressed: {
        if(serial.isOpen())
            serial.close()


        serial.open(serial.channels()[comboPuerto.currentIndex])
        if(serial.isOpen()){
            serial.paramSet('baud',comboBaudios.currentText)
            serial.paramSet('bits',comboBits.currentText)
            serial.paramSet('flow',comboFlujo.model.get(comboFlujo.currentIndex).value)
            serial.paramSet('stops',comboStop.currentText)
            serial.paramSet('parity',comboPar.model.get(comboPar.currentIndex).value)
            toast.show("Conexión Exitosa",2000,'green')
        }
        else{
            toast.show("Error de Conexión",2000,'red')
        }
    }
    checkBoxEcho.onCheckStateChanged: {
        window.echo = checkBoxEcho.checked
    }
    function updatePorts(){
        var info = serial.channelInfo(comboPuerto.textAt(comboPuerto.currentIndex))
        label_port_desc.text = "Descripción: "+ info[0]
        label_port_fab.text = "Fabricante: " + info[1]
        label_port_ser.text = "N° de Serie: " + info[2]
        label_port_ub.text = "Ubicación: " + info[3]
        label_port_vid.text = "VID: " + info[4]
        label_port_pid.text = "PID: " + info[5]
    }
}
