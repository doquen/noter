import QtQuick 2.4
import QtQuick.Controls 2.2

ConsoleForm {
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
            cursorVisible: true
            selectByMouse: true
            text: qsTr("")
            wrapMode: Text.WordWrap
            property int myCursorPosition: 0

            Component.onCompleted: {
                cursorPosition = 0
            }

            onMyCursorPositionChanged: {
                cursorPosition = myCursorPosition
            }

            Keys.onPressed: {
                if(consmode){
                    switch (event.key) {
                    case Qt.Key_Up:
                        serial.writeString("[A")
                        break
                    case Qt.Key_Down:
                        serial.writeString("[B")
                        break
                    case Qt.Key_Left:
                        serial.writeString("[D")
                        break
                    case Qt.Key_Right:
                        serial.writeString("[C")
                        break
                    case Qt.Key_Tab:
                        serial.writeString("H")
                        break
                    default:
                        if (textAreaConsole.activeFocus) {

                            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                                textAreaConsole.myCursorPosition = textAreaConsole.text.length
                            if(serial.isOpen){
                                serial.writeString(event.text)
                            }
                            if(localEcho){
                                var msg = [Number(event.text.charCodeAt(0))]
                                sendText(msg)
                            }
                        }

                    }

                }
                event.accepted = true
            }
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
        //if(hex)
            msg = msg.split("").map(function(x) {return Number(x.charCodeAt(0))})
        if(echo)
            sendText(msg)
    }

    function sendBytes(msg){
        textAreaConsole.insert(textAreaConsole.text.length,msg+" ")
    }
    function sendText(msg){

        if(!hex){
            var msg2 = serial.bytes2String(msg)
            var aux
            while (msg.length > 0){
                switch(msg[0]){
                case 0x08:
                    moveCursor(-1)
                    msg.shift()
                    break
                case 0x1b:
                    msg.shift()
                    msg.shift()
                    var n = Number(String.fromCharCode(msg[0]))
                    while(!isNaN(n)){
                        aux = aux*10+n
                        msg.shift()
                        n = Number(String.fromCharCode(msg[0]))
                    }
                    switch(msg[0]){
                    case 0x4b:
                        removeAllFromCursor()
                        break
                    case 0x44:
                        moveCursor(-aux)
                        break
                    }
                    msg.shift()
                    break
                default:
                    remove1Char()
                    print2Console(String.fromCharCode(msg[0]))
                    msg.shift()
                }

            }

        }
        else {
            msg = msg.map(function (x) {return "0x"+("00"+x.toString(16)).slice(-2)}).toString().replace(/,/g , " ");
            textAreaConsole.insert(textAreaConsole.text.length,msg+" ")
            textAreaConsole.myCursorPosition += msg.length + 1
        }
    }
    function remove1Char(){
        textAreaConsole.remove(textAreaConsole.myCursorPosition,textAreaConsole.myCursorPosition+1)
    }
    function removeAllFromCursor(){
        textAreaConsole.remove(textAreaConsole.myCursorPosition,textAreaConsole.text.length)
    }
    function moveCursor(n){
        textAreaConsole.myCursorPosition = textAreaConsole.myCursorPosition + n
    }
    function print2Console(msg){
        textAreaConsole.insert(textAreaConsole.myCursorPosition,msg)
        textAreaConsole.myCursorPosition += msg.length
    }

}
