import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12

import TableModel 1.0


Rectangle{

    id: rect

    TableView{
        id: tableview
        anchors.fill: parent
        columnSpacing: 3
        rowSpacing: 1
        clip: true
        model: tableModel

        property int currentRow

        delegate: Rectangle{
            id: tableCell

            border.color: "black"
            border.width: 2
            implicitWidth: rect.width / 3
            implicitHeight: 50
            color: (row !== 0 && row === tableview.currentRow) ? "blue" : (row % 2 === 0 ? "#F0F0F0" : "#FFFFFF")

            Text{
                anchors.centerIn: parent
                text: tabledata
            }
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                hoverEnabled: true
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
        anchors.topMargin: middleMargin
        text: "Delete"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Click on node row")

        onClicked: {

            var nodeName = tableModel.getProperty(tableview.model.index(tableview.currentRow, 0))

            appCore.deleteNode(nodeName);
        }


    }
}

