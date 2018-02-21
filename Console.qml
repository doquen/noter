import QtQuick 2.4
import QtQuick.Controls 2.2

ConsoleForm {

    Keys.onPressed: {
        if(consmode){
            switch (event.key) {
            default:
                if (textAreaConsole.activeFocus) {
                    if(serial.isOpen){
                        serial.writeString(event.text)
                    }
                    if(localEcho){
                        var msg = [Number(event.text.charCodeAt(0))]
                        sendText(msg)
                    }
                }

            }
            event.accepter = true
        }
    }


    buttonEnviar.onClicked: {
        var msg = textFieldConsole.text
        if(!switchHex.checked){
            if(serial.isOpen)
                serial.writeString(msg+comboBoxAppend.model.get(comboBoxAppend.currentIndex).value)
        }
        else {
            msg = msg.trim().split(" ")
            var arr = []
            for(var i = 0; i < msg.length; i++){
                var n = parseInt(msg[i],16)
                if (!isNaN(n)){
                    arr.push(n)
                }
                else{
                    arr = []
                    break
                }
            }
            if(arr.length > 0){
                msg = arr.map(
                            function(x){
                                return String.fromCharCode(x)
                            }
                            ).join("")
                if(serial.isOpen)
                    serial.writeString(msg+comboBoxAppend.model.get(comboBoxAppend.currentIndex).value)
            }
            else {
                toast.show("Error en caracteres Hexadecimales.",2000,'red')
            }
        }
        if(hex)
            msg = msg.split("").map(function(x) {return Number(x.charCodeAt(0))})
        if(echo)
            sendText(msg)
    }

    function sendBytes(msg){
        textAreaConsole.insert(textAreaConsole.text.length,msg+" ")
    }
    function sendText(msg){

        if(!hex){
            msg = serial.bytes2String(msg)
            if(msg.charCodeAt(0)==8){
                textAreaConsole.remove(textAreaConsole.text.length-1,textAreaConsole.text.length)
            }
            else{
                textAreaConsole.insert(textAreaConsole.text.length,msg)
            }
        }
        else {
            msg = msg.map(function (x) {return "0x"+("00"+x.toString(16)).slice(-2)}).toString().replace(/,/g , " ");
            textAreaConsole.insert(textAreaConsole.text.length,msg+" ")
        }
    }
}
