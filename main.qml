import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import Qt.labs.qmlmodels 1.0

import TableModel 1.0
import AppModule.Impl 1.0
import Graph 1.0

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
        Rectangle{

            width: parent.width / 1.3
            height: parent.height / 1.3
            anchors.centerIn: parent

            TableView{
                id: tableview
                anchors.fill: parent
                columnSpacing: 1
                rowSpacing: 1
                clip: true

                model: TableModel{
                   id: tableModel
                }

                delegate: Rectangle{
                    border.color: "black"
                    border.width: 2
                    implicitWidth: 100
                    implicitHeight: 50
                    color: (heading == true)? "grey" : "white"
                    Text{
                        anchors.centerIn: parent
                        text: tabledata
                    }
                }
            }
        }

        Rectangle{
            id: createNodeBtn
            width: parent.width / 3
            height: parent.height / 2
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: defMargin

            ColumnLayout{

                CustomInputField{
                    id: nameField
                    name: "Node name"
                }
                CustomInputField{
                    id: coordinateX
                    name: "Coordinate X"
                }
                CustomInputField{
                    id: coordinateY
                    name: "Coordinate Y"
                }
            }

            Button {
                text: "Add node to graph"
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                onClicked: {
                    graph.createNodeRequest(nameField.text, coordinateX.text, coordinateY.text)
                    //update table
                    tableModel.updateData()
                    nameField.text = ""
                    coordinateX.text = ""
                    coordinateY.text = ""
                }
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
