import QtQuick 2.11
import QtQuick.Controls 2.2

ConsoleForm {
    property bool opened
    property string currentText: ""

    opened: config.radioButtonSerie.checked ? serial.openned :
                                              (config.radioButtonSsh.checked) ? ssh.opened : false

    onCurrentTextChanged: {
        textAreaConsole.text = currentText
    }

    Shortcut {
        sequence: "Alt+C"
        onActivated: connect()
    }
    Shortcut {
        sequence: "Ctrl+L"
        onActivated: clearText()
    }
    Shortcut {
        sequence: "Ctrl+E,Ctrl+W"
        onActivated: edit.wrapMode = TextEdit.Wrap
    }

    clearButton.onClicked:{
        clearText()
    }
    connectButton.icon.source: opened ? "connect.png" : "disconnect.png"
    connectButton.onPressed: {
        connect()
    }

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
            //textFormat: TextEdit.RichText
            //text: qsTr('<h1>Bienvenido a NoTer</h1>\n<h2>Atajos de Teclado:</h2>\nCTRL+L: Limpiar terminal.<br>ALT+C: Conectar/Desconectar.\n')
            wrapMode: Text.WordWrap
            property int myCursorPosition: 0
            property int savedCursorPosition: 0

            Component.onCompleted: {
                cursorPosition = 0
            }
            // TODO: solo scrollear cuando no se está al final del texto
            onMyCursorPositionChanged: {
             //   cursorPosition = myCursorPosition
            }

            Keys.onPressed: {
                if(consmode){
                    switch (event.key) {
                    case Qt.Key_Up:
                        writeString("[A")
                        break
                    case Qt.Key_Down:
                        writeString("[B")
                        break
                    case Qt.Key_Left:
                        writeString("[D")
                        break
                    case Qt.Key_Right:
                        writeString("[C")
                        break
                    case Qt.Key_Tab:
                        writeString("\t")
                        break
                    default:
                        if (textAreaConsole.activeFocus) {
                            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                                textAreaConsole.myCursorPosition = textAreaConsole.text.length
                            if(opened){
                                writeString(event.text)
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
            if(opened)
                writeString(msg+comboBoxAppend.model.get(comboBoxAppend.currentIndex).value)
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
                if(opened)
                    writeString(msg+comboBoxAppend.model.get(comboBoxAppend.currentIndex).value)
            }
            else {
                toast.show(qsTr("Error en caracteres Hexadecimales."),2000,'red')
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
        //unparsed += msg;
        //msg = ssh.parseVT100(msg);
        //textAreaConsole.text += msg;
        //textAreaConsole.myCursorPosition = textAreaConsole.text.length
        if(!hex){
            var msg2 = serial.bytes2String(msg)
            parse_ansi(msg2)
            while (msg.length > 0){
                var aux = 0
                switch(msg[0]){
                case 0x0d:
                    if (Qt.platform.os == "linux")
                        msg.shift()
                    break
                case 0x08:
                    moveCursor(-1)
                    msg.shift()
                    break
                case 0x1b:
                    msg.shift()
                    if (msg[0]==0x5b){
                        msg.shift()
                        var n = Number(String.fromCharCode(msg[0]))
                        while(!isNaN(n)){
                            aux = aux*10+n
                            msg.shift()
                            n = Number(String.fromCharCode(msg[0]))
                        }
                        switch(msg[0]){
                        case 0x4b:
                            if (aux){
                                eraseLine(aux)
                            } else {
                                eraseLine(0)
                            }
                            break
                        case 0x44:
                            moveCursor(-aux)
                            break
                        case 'm':
                            var a = 0;
                        }
                        msg.shift()
                    }
                    break

                default:
                    remove1Char() //Par que estaba esto aca?
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
        textAreaConsole.myCursorPosition += n
    }
    function print2Console(msg){
        textAreaConsole.insert(textAreaConsole.myCursorPosition,msg)
        textAreaConsole.myCursorPosition += msg.length
    }
    function clearText(){

        if (consmode && !hex){
            var currentText = textAreaConsole.text.split("\n")
            textAreaConsole.clear()
            textAreaConsole.text = currentText[currentText.length-1]
            textAreaConsole.myCursorPosition = textAreaConsole.text.length
        }else{
            textAreaConsole.clear()
            textAreaConsole.myCursorPosition = textAreaConsole.text.length
        }
    }
    function connect() {
        if (config.radioButtonSerie.checked)
            config.connectPort()
        else if (config.radioButtonSsh.checked)
            config.connectSsh()
    }
    function writeString(str){
        if (config.radioButtonSerie.checked)
            serial.writeString(str)
        else if (config.radioButtonSsh.checked)
            ssh.writeData(str)
    }
    function eraseLine(mode){
        var i;
        var j;
        switch (mode){
        case 0:
            i = textAreaConsole.myCursorPosition
            j = textAreaConsole.text.indexOf('\n',textAreaConsole.myCursorPosition)
            break
        case 1:
            i = textAreaConsole.text.lastIndexOf('\n',textAreaConsole.myCursorPosition)
            i = textAreaConsole.myCursorPosition
            break
        case 2:
            i = textAreaConsole.text.lastIndexOf('\n',textAreaConsole.myCursorPosition)
            j = textAreaConsole.text.indexOf('\n',textAreaConsole.myCursorPosition)
            break
        }
        if (i === -1) i = 0;
        if (j === -1) j = textAreaConsole.text.length
        textAreaConsole.remove(i,j+1)
    }

    function parse_ansi(msg){
        var aux = []
        var arr = msg.split(String.fromCharCode(0x1b));
        console.log(arr)
        for (var i = 0; i < arr.length ; i++){
            var res = arr[i].match(/(?<=[)(.*)[^0-9]/);
        }
    }
}
