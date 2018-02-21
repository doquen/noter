import QtQuick 2.4
import QtQuick.Controls 2.3

Page {
    id: page
    width: 400
    height: 800
    property alias textAreaText2: textAreaText2
    property alias textAreaHexa2: textAreaHexa2
    property alias textAreaText: textAreaText
    property alias textAreaHexa: textAreaHexa
    anchors.fill: parent
    title: "Utilidades"
    Flickable{
        anchors.fill: parent
        contentHeight: groupBox.height + groupBox1.height + 30
        ScrollBar.vertical: ScrollBar { }
    GroupBox {
        id: groupBox
        height: 300
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 10
        title: qsTr("Texto a Hexa:")
        ScrollView{
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            width: parent.width / 2 - 10
            TextArea {
                id: textAreaText
                wrapMode: Text.WordWrap
                selectByMouse: true
                inputMethodHints: Qt.ImhNoPredictiveText;
            }
        }
        ScrollView{
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.top: parent.top
            width: parent.width / 2 - 10

            TextArea {
                id: textAreaHexa
                text: qsTr("")
                readOnly: true
                wrapMode: Text.WordWrap
                selectByMouse: true
            }
        }
    }

    GroupBox {
        id: groupBox1
        x: -7
        height: 300
        anchors.top: groupBox.bottom
        anchors.topMargin: 10
        ScrollView {
            width: parent.width / 2 - 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            TextArea {
                id: textAreaHexa2
                wrapMode: Text.WordWrap
                selectByMouse: true
                inputMethodHints: Qt.ImhNoPredictiveText
            }
            anchors.topMargin: 5
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        ScrollView {
            width: parent.width / 2 - 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            TextArea {
                id: textAreaText2
                textFormat: TextArea.RichText
                text: qsTr("")
                wrapMode: Text.WordWrap
                selectByMouse: true
                readOnly: true
            }
            anchors.topMargin: 5
            anchors.top: parent.top
            anchors.rightMargin: 5
            anchors.right: parent.right
        }
        title: qsTr("Hexa a Texto:")
        spacing: 10
        anchors.left: parent.left
        anchors.rightMargin: 10
        anchors.right: parent.right
        anchors.leftMargin: 10
    }
    }
}
