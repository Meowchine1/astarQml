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

    Item{
        id: root
        property int size: 100
        property color color: "blue"
        property alias text: caption.text

        signal clicked()

        width:size
        height:size


        Rectangle{
            anchors.fill: parent
            radius: size/2

            Text {
                id: caption
                text: qsTr("text")
                anchors.centerIn: parent
            }
            MouseArea{
                id: mouseArea
                anchors.fill: parent
                onClicked: {

                    root.clicked()
                }
            }
        }
    }
}
