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
    visible: false
    onButtonClicked: {
        stackView.pop(mainPage);
    }
    Rectangle{
        anchors.fill: parent
        color: backgroundColor
        Switch{
            id: drawMode
            text: qsTr("Drawing")
            anchors.horizontalCenter: graphArea.horizontalCenter
            anchors.bottom:graphArea.top
            anchors.bottomMargin: defMargin
            onCheckedChanged: {
                if(drawMode.checked){
                   tableview.clear()
                    randomModel.emptyGraph()
                }
            }
        }
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
            anchors.topMargin: 2 * middleMargin
            TableView{
                id: tableview
                property int startRow: -1
                property int startColumn: -1
                property int finishRow: -1
                property int finishColumn: -1
                property ListModel highlightedCells: ListModel {}
                property ListModel visitedCells: ListModel {}
                function find(model, criteria) {
                  for(var i = 0; i < model.count; ++i){
                      if (criteria(model.get(i))) return model.get(i)
                  }
                  return null
                }
                function clear(){
                    tableview.highlightedCells.clear()
                    tableview.visitedCells.clear()
                    tableview.startRow =  -1
                    tableview.startColumn = -1
                    tableview.finishRow = -1
                    tableview.finishColumn = -1
                }
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
                        for (var j = 0; j < tableview.visitedCells.count; j++) {
                            if (tableview.visitedCells.get(j).row === row && tableview.visitedCells.get(j).column === column) {
                                return "blue";
                            }
                        }
                        for (var i = 0; i < tableview.highlightedCells.count; i++) {
                            if (tableview.highlightedCells.get(i).row === row && tableview.highlightedCells.get(i).column === column) {
                                return "skyblue";
                            }
                        }
                        return (emptyNode === true) ? "black" :
                                                      (row === tableview.startRow && column === tableview.startColumn)? "green":(row === tableview.finishRow && column === tableview.finishColumn)? "red":"pink"
                    }
                    MouseArea{
                        id:mouseArea
                        visible: !drawMode.checked
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        anchors.fill: parent
                        onClicked: {
                            if(Qt.colorEqual(cell.color, '#ffc0cb')){
                                if (mouse.button === Qt.RightButton && !(row === tableview.finishRow & column === tableview.finishColumn)) {
                                    tableview.finishRow = row
                                    tableview.finishColumn = column
                                    if (tableview.highlightedCells.count > 0) {
                                        tableview.highlightedCells.clear()
                                        tableview.visitedCells.clear()
                                    }
                                }
                                else{
                                    if(!(row === tableview.startRow & column === tableview.startColumn)){
                                        tableview.startRow = row
                                        tableview.startColumn = column
                                        if (tableview.highlightedCells.count > 0) {
                                            tableview.highlightedCells.clear()
                                            tableview.visitedCells.clear() }
                                    }
                                }
                            }
                        }
                    }
                    MouseArea{
                    id:drawingMouseArea
                    visible: drawMode.checked
                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    onClicked: {
                        var i = row, j = column
                        if(Qt.colorEqual(cell.color, '#ffc0cb')){
                            if (mouse.button === Qt.LeftButton) {
                                randomModel.addEmptyNode(i, j)
                            }
                        }
                        else{
                            if (mouse.button === Qt.LeftButton) {
                                randomModel.deleteEmptyNode(i, j)
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
            color: !drawMode.checked? backgroundColor : "pink"
            TextArea{
                wrapMode : TextEdit.WordWrap
                width: parent.width * 0.7
                visible: drawMode.checked
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("To start algorithm turn off switch object")
            }
            ColumnLayout{
                visible: !drawMode.checked
                anchors.top: manageArea.top
                anchors.left: manageArea.left
                anchors.leftMargin: middleMargin
                anchors.topMargin: defMargin
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
                                    tableview.highlightedCells.append({ row: x, column: y});
                                }
                                var visitedCoordinates = appCore.getVisited();
                                for (i = 0; i < visitedCoordinates.length; i += 2) {
                                     x = parseInt(visitedCoordinates[i]);
                                     y = parseInt(visitedCoordinates[i + 1]);
                                    if(!tableview.find(tableview.highlightedCells, function(item) {
                                        return item.row === x && item.column === y
                                    })){
                                        tableview.visitedCells.append({ row: x, column: y});
                                    }
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
                        if(drawMode.checked){
                             randomModel.emptyGraph()
                        }
                        tableview.clear()
                    }
                }
                Button{
                    id: resetGraph
                    text: "reset graph"
                    onClicked:{
                        tableview.clear()
                        randomModel.resetGraph();
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
            clip: true
            contentItem: TextArea{
                wrapMode : TextEdit.WordWrap
                width: parent.width * 0.7
                text:"For testing algorithm with random graph you should choose start node by left mouse pressing(cell become green color). Also you need to choose finish node by right mouse pressing (cell become red color).After choosing press start algorithm button.
 If you want to make custom graph you should turn on switch object and draw border cells by left mouse pressing (delete border cell -- click on it). After drawing turn off switch object and press start algorithm button.

ALGORITNM WORK RESULT: shortest way consist from skyblue cells. Remaining visited cells marked dark blue"
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
