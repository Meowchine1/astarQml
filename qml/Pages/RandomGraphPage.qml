import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.0


import AppCore 1.0
import RandomModel 1.0
import Base 1.0

BasePage{
    id:randomGraphPage
    //title: "Random graph"
    visible: false
    onButtonClicked: {
        stackView.pop(mainPage);
    }

    Rectangle{
        anchors.fill: parent
        color: backgroundColor
        Rectangle{
            id: graphArea
            width: parent.width / 1.5
            height: parent.height / 1.5
            radius: radiusValue
            border.width: 2
            border.color: borderColor
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: defMargin
            TableView{
                id: tableview
                property int startRow: -1
                property int startColumn: -1
                property int finishRow: -1
                property int finishColumn: -1
                property ListModel highlightedCells: ListModel {}
                width: graphArea.width * 0.8
                height: graphArea.height * 0.8
                anchors.centerIn: parent
                model: randomModel
                interactive: false
                columnWidthProvider: tableview.width / (randomModel.columnCount())
                rowHeightProvider: tableview.height / (randomModel.rowCount())
                delegate: Rectangle{
                    id: cell
                    implicitWidth: tableview.width / (randomModel.columnCount())
                    implicitHeight: tableview.height / (randomModel.rowCount())
                    border.width: 1
                    border.color: "grey"
                    color:{
                        for (var i = 0; i < tableview.highlightedCells.count; i++) {
                            if (tableview.highlightedCells.get(i).row === row && tableview.highlightedCells.get(i).column === column) {
                                return "skyblue";
                            }
                        }
                        return (emptyNode === true) ? "black" :
                                                      (row === tableview.startRow && column === tableview.startColumn)? "green":
                                                                                                                        (row === tableview.finishRow && column === tableview.finishColumn)? "red":"pink"
                    }
                    MouseArea{
                        id:mouseArea
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        anchors.fill: parent
                        onClicked: {
                            if(row.color !== "black"){
                                if ( mouse.button === Qt.RightButton && !(row === tableview.finishRow & column === tableview.finishColumn)) {

                                    tableview.finishRow = row
                                    tableview.finishColumn = column
                                    if (tableview.highlightedCells.count > 0) { tableview.highlightedCells.clear() }
                                }
                                else{
                                    if(!(row === tableview.startRow & column === tableview.startColumn)){
                                        tableview.startRow = row
                                        tableview.startColumn = column
                                        if (tableview.highlightedCells.count > 0) { tableview.highlightedCells.clear() }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            id: border
            width: 2
            height: win.height
            anchors.right: manageArea.left
            color: "blue"
        }
        Rectangle{
            id: manageArea
            width: win.width - graphArea.width - 2*defMargin
            height:win.height
            anchors.top: win.top
            anchors.left: graphArea.right
            anchors.margins: defMargin
            radius: radiusValue
            color: backgroundColor
            ColumnLayout{
                anchors.top: manageArea.top
                anchors.left: manageArea.left
                anchors.leftMargin: middleMargin
                anchors.topMargin: defMargin
                //                Rectangle{
                //                    id: startAlg
                //                    width:100
                //                    height:50
                //                    Text{
                //                        text: "start algorithm"
                //                    }
                //                    border.width: 2
                //                    border.color: Material.color(Material.Blue, 2)
                //                    color: mouseArea2.containsMouse ? focusedBorderColor : borderColor
                //                    MouseArea{
                //                        id: mouseArea2
                //                        anchors.fill: parent
                //                        hoverEnabled: true
                //                        onClicked: {
                //                    }
                //                }
                Button{
                    id: startAlg
                    text: "start algorithm"
                    focus: true
                    onClicked: {
                        if(tableview.highlightedCells.count === 0){
                            if (tableview.startColumn !== -1 && tableview.finishColumn !== -1) {
                                var minPathCoordinates = appCore.startAlgorithmWithAutogeneratedGraph(
                                            tableview.startColumn,
                                            tableview.startRow,
                                            tableview.finishColumn,
                                            tableview.finishRow
                                            );
                                for (var i = 0; i < minPathCoordinates.length; i += 2) {
                                    var x = parseInt(minPathCoordinates[i]);
                                    var y = parseInt(minPathCoordinates[i + 1]);

                                    console.warn("x[", i, "]=",x)
                                    console.warn("y[", i, "]=",y)
                                    tableview.highlightedCells.append({ row: x, column: y});
                                }
                            }
                            else{
                                messageDialog.message = "Choose start and finish nodes"
                                messageDialog.open()
                            }
                        }
                        else{
                            messageDialog.message = "Clear map"
                            messageDialog.visible = true
                        }
                    }
                }
                Button{
                    id: clear
                    text: "clear map"
                    onClicked:{
                        tableview.highlightedCells.clear()
                        tableview.startRow =  -1
                        tableview.startColumn = -1
                        tableview.finishRow = -1
                        tableview.finishColumn = -1
                    }
                }
                Button{
                    id: resetGraph
                    text: "reset graph"
                    onClicked:{
                        randomModel.resetGraph();
                        tableview.highlightedCells.clear()

                    }
                }
                Button{
                    id: help
                    text: "How to use"
                    onClicked: popup.open()
                }
            }
        }
    }
    MessageDialog {
        id: messageDialog
    }
    Rectangle{
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        visible: false
        Popup {
            id: popup
            anchors.centerIn: parent
            width: 400
            height: 500
            modal: true
            focus: true
            dim: true
            contentItem: Text{

                text:"Left mouse press to choose start node (green node). Right
 mouse press to choose finish node (red node)"
            }

            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            enter: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity";
                        from: 0.0;
                        to: 1.0;
                        duration: 300
                    }
                    NumberAnimation {
                        property: "scale";
                        from: 0.4;
                        to: 1.0;
                        easing.type: Easing.OutBack
                        duration: 300
                    }
                }
            }
            exit: Transition {
                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity";
                        from: 1.0
                        to: 0.0;
                        duration: 300
                    }
                    NumberAnimation {
                        property: "scale";
                        from: 1.0
                        to: 0.8;
                        duration: 300
                    }
                }
            }
        }
    }
}
