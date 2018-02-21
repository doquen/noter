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

    textFieldConsole.onTextChanged: {
        if(switchHex.checked)
        textFieldConsole.text = textFieldConsole.text.split(" ").map(
                    function(x){
                        var n = parseInt(x,16)
                        return isNaN(n) ? "<span style='color:#FF0000'> "+x+" </span>" :
                                          x

                    }
                    ).join("")
    }

    buttonEnviar.onClicked: {
        var msg = textFieldConsole.text +comboBoxAppend.model.get(comboBoxAppend.currentIndex).value
        if(!switchHex.checked){
            if(serial.isOpen)
                serial.writeString(msg)

            if(hex && echo){
                msg = msg.split("").map(function(x) {return Number(x.charCodeAt(0))})
                sendText(msg)
            }
        }
        else {

        }
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
