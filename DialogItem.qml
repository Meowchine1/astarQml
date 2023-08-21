import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import Qt.labs.platform 1.1

Rectangle {
    id: root
    property alias  text: message.text
    property alias dialog_height : root.height
    property alias dialog_width : root.width
    property variant buttons: []  //'0', '1']

    signal clicked(int index);

   // width: 200;  height: 200

    MouseArea{ anchors.fill: parent }

    Text {
        id: message
        anchors{
            centerIn: parent;
            verticalCenterOffset: -0.1 * root.height
        }
       font.pixelSize: 0.1 * root.height
        width: 0.9 * parent.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Row { // buttons
        id: row

        anchors{
            bottom: parent.bottom;
            horizontalCenter: parent.horizontalCenter;
            bottomMargin: 0.1 * root.height
        }

        spacing: 0.03 * root.width

        Repeater {
            id: repeater
            model: buttons

            delegate: Button {
                width: Math.min(0.5 * root.width, (0.9 * root.width - (repeater.count - 1) * row.spacing) / repeater.count)
                height: 0.2 * root.height
                text:  modelData

                onClicked: root.clicked(index)
            }
        }
    }
}
