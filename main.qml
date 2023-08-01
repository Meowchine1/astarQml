import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12

Window {
    id: win
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Button{
        id: button1
        text: "Click me"
        anchors.centerIn: parent
        onClicked: {
            win.color = Qt.rgba(1,0,1)


        }
    }

    RoundButton {
        id: root
    }
}
