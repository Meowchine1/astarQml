import QtQuick 2.5
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

import Graph 1.0
import TableModel 1.0

ApplicationWindow {
    id: win
    width: 800
    height: 480
    visible: true
    title: qsTr("Graph algorithm")
    Graph{
        id: graph
    }

    header: ToolBar{
        height: 50
        ToolButton{
            id: btnBack
            text: "<"
            visible: stackView.depth > 1
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                popPage();
            }
        }
        Text {
            anchors.centerIn: parent
            font.pointSize: 16
            text: stackView.currentItem.title
        }
    }


    property int defMargin: 10
    property int defSpacing: 100

    function popPage(){

        stackView.pop();
    }

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainPage
    }

    BasePage {
        id: mainPage
        title: "Main page"
        backgroundColor: "blue"

        Rectangle{
            anchors.centerIn: parent
            width: parent.width / 2
            height: parent.height / 2
            color: mainPage.backgroundColor

            ColumnLayout{
                id: btnLayout
                spacing: defSpacing
                anchors.fill: parent
                Button{
                    id: manualbtn
                    text: "Manual creating"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onClicked: {
                        stackView.push(manualCreatingPage)
                    }
                }
                Button{
                    id: readbtn
                    text: "Read txt file"
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onClicked: {
                        stackView.push(readGraphPage)
                    }
                }
            }
        }
    }

    BasePage {
        id: manualCreatingPage
        title: "Manual creating"
        visible: false
        backgroundColor: "pink"
        buttonText: "Back"
        onButtonClicked: {
            stackView.pop(mainPage);
        }

        TableModel {
            id: tableModel
        }

        TableView {
            id: tableView
            anchors.fill: parent
            model: tableModel

            // Добавляем колонки
            Component.onCompleted: {
                tableView.addColumn("Column 1")
                tableView.addColumn("Column 2")
            }

            // Отображаем ячейки с данными
            delegate: Item {
                height: 30
                Row {
                    spacing: 10
                    Repeater {
                        model: tableView.columnCount
                        Text {
                            text: tableView.model.data(index, Qt.EditRole)
                        }
                    }
                }
            }
        }

        Button {
            text: "Add Row"
            onClicked: {
                tableModel.insertRows(tableModel.rowCount, 1)
            }
        }

    Button{
        id: createGraph
        text: "CREATE GRAPH"
        anchors.bottom: parent.bottom;
        anchors.right: parent.right
        anchors.margins: defMargin
        onClicked: {
            for (var row = 0; row < dataModel.rowCount; ++row) {
                var rowData = []
                var name = dataModel.get(row, 0).value
                var x = dataModel.get(row, 1).value
                var y = dataModel.get(row, 2).value
                graph.addNode(name, x, y);
            }
        }
    }
}

BasePage {
    id: readGraphPage
    title: "Read graph"
    visible: false
    backgroundColor: "green"
    buttonText: "Back"
    onButtonClicked: {
        stackView.pop(mainPage);
    }
    Text{
        id: path
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text:"Path to graph model"
        width: parent.width/2
    }
    ColumnLayout{
        spacing: 100
        anchors.centerIn: parent
        Button {
            anchors.right: parent.left
            text: "Open File Manager"
            onClicked: {
                fileDialog.open();
            }
        }
        Button{
            anchors.right: parent.left
            visible: path.text != "Path to graph model"
            text: "Upload graph model"
            onClicked: {
                // go next and graph.readTxt
            }
        }
    }
}

FileDialog {
    id: fileDialog
    title: "Please choose a file"
    folder: shortcuts.home
    nameFilters: [ "Txt files (*.txt )"]
    onAccepted: {
        path.text = this.fileUrl
        //передать путь c++
    }
    onRejected: {
        console.log("Canceled")
        Qt.quit()
    }
}



}
