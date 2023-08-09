import QtQuick 2.5
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

import TableParser 1.0

ApplicationWindow {
    id: win
    width: 800
    height: 480
    visible: true
    title: qsTr("Graph algorithm")

    Parser{
        id: parser

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

        Rectangle {
            width: 360
            height: 360

            ListModel {
                id: dataModel

                ListElement {
                    color: "orange"
                    text: "first"
                }
                ListElement {
                    color: "lightgreen"
                    text: "second"
                }
                ListElement {
                    color: "orchid"
                    text: "third"
                }
                ListElement {
                    color: "tomato"
                    text: "fourth"
                }
            }

            OldControls.TableView {
                id: view

                anchors.margins: 10
                anchors.fill: parent
                model: dataModel
                clip: true

                OldControls.TableViewColumn {
                    width: 100
                        title: "Color"
                        role: "color"
                        delegate: Rectangle {
                            color: styleData.value
                        }
                }
                OldControls.TableViewColumn {
                    width: 100
                    title: "Text"
                    role: "text"
                }

                itemDelegate: Item {
                    Text {
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering
                        text: styleData.value
                    }
                }

            }

            Button{

                id: createGraph

                onClicked: {
                    var tableData = []
                           for (var row = 0; row < dataModel.rowCount; ++row) {
                               var rowData = []
                               for (var column = 0; column < dataModel.columnCount; ++column) {
                                   rowData.push(dataModel.get(row, column).value)
                               }
                               tableData.push(rowData)
                           }

                           // Передача данных таблицы в C++ код
                           parser.setTableData(tableData)
                }
            }
        }

//        ColumnLayout{
//            spacing: defMargin
//            anchors.centerIn: parent
//            CustomInputField{
//                id: nodeName
//                fieldName: "Node name"
//            }
//            CustomInputField{
//                id: xCoord
//                fieldName: "X coordinate"
//            }
//            CustomInputField{
//                id: yCoord
//                fieldName: "Y coordinate"
//            }
//            Button{
//                text:"create"
//                onClicked: {
//                    // add node to graph
//                    app.createNodeRequest(nodeName.text, xCoord.text, yCoord.text);
//                    nodeName.text = ""
//                    xCoord.text = ""
//                    yCoord.text = ""
//                }
//            }

//            ListModel{



//            }
//        }
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

    BasePage{


    }

}


