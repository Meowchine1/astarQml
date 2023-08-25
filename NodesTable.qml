import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12

import TableModel 1.0

Rectangle{
    id: rect
    radius: 5
    TableView{
        id: tableview
        anchors.fill: parent
        columnSpacing: 3
        rowSpacing: 1
        clip: true
        property int currentRow: 0
        model: tableModel
        delegate: Rectangle{
            id: tableCell
            radius: 10
            border.color: grey
            border.width: 2
            implicitWidth: rect.width / 3
            implicitHeight: 50
            color: (heading !== true && row === tableview.currentRow) ? Qt.lighter(grey) : (heading === true)? Qt.darker(grey) : grey
            Text{
                font.pixelSize: middlefontSize
                anchors.centerIn: parent
                text: tabledata
            }
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                onClicked: {
                    tableview.currentRow = row
                }
            }


        }
        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
            active: true
            onActiveChanged: {
                if (!active)
                    active = true;
            }
        }
    }
    Button{
        id:deleteNode
        anchors.top: rect.bottom
        anchors.left: rect.left
        font.pixelSize: middlefontSize
        anchors.topMargin: middleMargin
        text: "Delete"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Click on node row")

        onClicked: {
            if(tableview.currentRow !== 0){
                var nodeName = tableModel.getProperty(tableview.model.index(tableview.currentRow, 0))
                tableview.currentRow = 0
                appCore.deleteNode(nodeName);
            }
            else{
                messageDialog.text = "Empty response"
                messageDialog.visible = true
            }
        }
    }

    DialogItem {
        id: messageDialog
        visible: false
        buttons: ['Ok']
        dialog_width: parent.width
        dialog_height: parent.height
        color: "grey"
        anchors.centerIn: parent
        onClicked: visible = false
    }
}

