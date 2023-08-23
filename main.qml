import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.12
//import Qt.labs.platform 1.1   мешает File Dialog


import TableModel 1.0
import AppModule.Impl 1.0
import AppCore 1.0
import CustomListModel 1.0


ApplicationWindow {

    id: win
    width: 800
    height: 480
    visible: true
    title: qsTr("Graph algorithm")
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    property var repeaterFromNodes: []
    property var repeaterToNodes: []

    property int defMargin: 10
    property int defSpacing: 100
    property int middleMargin: 50

    function isInt(input) {
        var intRegex = /^\d{1,10}$/
        return intRegex.test(input)
    }

    function isEmpty(input) {
        var emptyRegex = /^\s*$/
        return emptyRegex.test(input)
    }
    header: ToolBar{
        height: 50
        ToolButton{
            id: btnBack
            text: "<"
            visible: stackView.depth > 1
            anchors.verticalCenter: parent.verticalCenter
            onClicked:
            {
                popPage();
            }
        }
        Text {
            anchors.centerIn: parent
            font.pointSize: 16
            text: stackView.currentItem.title
        }
    }

    function popPage(){ stackView.pop(); }

    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainPage
    }

    BasePage {
        id: mainPage
        title: "Main page"

        Rectangle{
            anchors.centerIn: parent
            width: parent.width / 2
            height: parent.height / 2

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
        onButtonClicked: {
            stackView.pop(mainPage);
        }

        NodesTable {
            id: rect
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width / 2
            height: parent.height / 2
            anchors.topMargin: middleMargin
            anchors.leftMargin: middleMargin
        }

        NodeCreationArea {
            id: createNodeBtn
            width: parent.width / 3
            height: parent.height / 2
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: middleMargin
        }

        Button{
            text: "NEXT STEP"
            anchors.bottom: parent.bottom;
            anchors.right: parent.right
            anchors.margins: defMargin
            onClicked: {
                stackView.push(relationsPage)
                appCore.nodeNamesRequest()
            }
        }
    }

    BasePage {
        id: readGraphPage
        title: "Read graph"
        visible: false
        buttonText: "Back"
        onButtonClicked: {
            stackView.pop(mainPage);
        }

        Rectangle{
            width: parent.width / 2
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top

            Button {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: middleMargin
                anchors.topMargin: middleMargin
                text: "Open File Manager"
                onClicked: {
                    fileDialog.open();
                }
            }
        }

        Rectangle{
            width: parent.width / 2
            height: parent.height / 2
            anchors.right: parent.right
            anchors.top: parent.top

            CustomInputField{
                id: path
                readonly: true
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: middleMargin
                placeholderText: "Path to graph model"
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 2
            anchors.bottom: parent.bottom
            Button{
                anchors.centerIn: parent
                anchors.topMargin: defMargin
                visible: path.text != ""
                text: "Upload graph model"
                onClicked: {
                    appCore.readGraphFromTxtRequest(path.text)
                    stackView.push(fileRelationsPage)
                    appCore.nodeNamesRequest()
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
        }
        onRejected: {
            console.warn("Canceled")
            Qt.quit()
        }
    }

    RelationsPage {
        id: fileRelationsPage
           Component.onCompleted: {
           console.warn("hello11")
           }
    }

    RelationsPage{
        id: relationsPage
    }

    BasePage{
        id: astarPage
        visible: false
        Rectangle{
            anchors.fill: parent

            Rectangle{
                width: parent.width / 1.3
                height: parent.height / 1.3
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: middleMargin

                RowLayout{
                    id: topRow
                    spacing: 20
                    ComboBox {
                        id:startNode
                        width: 200
                        model: listModel
                        textRole: "name"
                        Label{
                            text:"from"
                            anchors.bottom: parent.top
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
                    ComboBox {
                        id:finishNode
                        width: 200
                        model: listModel
                        textRole: "name"
                        Label{
                            text:"to"
                            anchors.bottom: parent.top
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
                }
                RowLayout{
                    anchors.top: topRow.bottom
                    spacing: 20
                    anchors.margins: middleMargin
                    Button{
                        text: "Start alrgorithm"
                        onClicked: {
                            var shortestWay = appCore.startAlgorithmRequest(startNode.currentText, finishNode.currentText)
                            minWay.text = shortestWay

                        }
                    }
                    Text {
                        id: minWay
                        text: qsTr("Algorithm's work result: ")

                    }

                }


            }
        }

    }
}
