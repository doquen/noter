import QtQuick 2.4

UtilidadesForm {
    textAreaHexa.text: textAreaText.text.split("").map(
                           function(x){
                               return "0x"+("00"+x.charCodeAt(0).toString(16)).slice(-2)+" "
                           }
                           ).join("")
    textAreaText2.text: textAreaHexa2.text.split(" ").map(
                            function(x){
                                var ret = ""
                                if(x!==""){
                                    var n = parseInt(x,16)
                                    ret = isNaN(n) ? "<span style='color:#FF0000'> ?? </span>" : String.fromCharCode(n)
                                }
                                return ret
                            }
                            ).join("")

}
