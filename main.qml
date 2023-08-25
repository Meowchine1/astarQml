import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.12

import TableModel 1.0
import AppCore 1.0
import CustomListModel 1.0

ApplicationWindow {

// COLOR START
    Material.theme: Material.Dark
    Material.accent: Material.Pink
    Material.primary: Material.Grey
    Material.foreground: Material.Pink
    property color grey: "#dadada"
// COLOR END


    property int nodeSize: 50
    property int comboboxSize: 400

    id: win
    width: 1000
    height: 480
    visible: true
    title: qsTr("Graph algorithm")

    property var repeaterFromNodes: []
    property var repeaterToNodes: []

    property int defMargin: 10
    property int defSpacing: 100
    property int middleMargin: 50

    property int btnWidth: 400

    property int fontSize: 25
    property int middlefontSize: 18

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
            font.pixelSize: 20
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
            ColumnLayout{
                id: btnLayout
                anchors.centerIn: parent

                Button{
                    id: manualbtn
                    Layout.fillWidth: true
                    Layout.preferredWidth: btnWidth
                    font.pixelSize: fontSize
                    text: "Manual creating"

                    onClicked: {
                        stackView.push(manualCreatingPage)
                    }
                }
                Button{
                    id: readbtn
                    Layout.fillWidth: true
                    Layout.preferredWidth: btnWidth
                    font.pixelSize: fontSize
                    text: "Read txt file"
                    onClicked: {
                        stackView.push(readGraphPage)
                    }
                }

                Button{
                    id: exitbtn
                    Layout.fillWidth: true
                    Layout.preferredWidth: btnWidth
                    font.pixelSize: fontSize
                    text: "Exit"
                    onClicked: {
                        win.close()
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
            anchors.top: parent.top
            anchors.topMargin: middleMargin
            anchors.leftMargin: middleMargin
            anchors.left: rect.right
        }

        NextBtn {
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
        onButtonClicked: {
            stackView.pop(mainPage);
        }

        Item{
            width: parent.width / 2
            height: parent.height / 2
            anchors.left: parent.left
            anchors.top: parent.top
            Button {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: middleMargin
                anchors.topMargin: middleMargin
                implicitWidth: 300
                font.pixelSize: 25
                text: "Open File Manager"
                onClicked: {
                    fileDialog.open();
                }
            }
        }

        Item{
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
                implicitWidth: 300
              //  font.pixelSize: 25
            }
        }

        Item{
            width: parent.width
            height: parent.height / 2
            anchors.bottom: parent.bottom
            Button{
                anchors.centerIn: parent
                anchors.topMargin: defMargin
                implicitWidth: 400
                font.pixelSize: 20
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
    }

    RelationsPage {
        id: fileRelationsPage
    }

    RelationsPage{
        id: relationsPage
    }

    BasePage{
        id: astarPage
        visible: false
        title: "A* algorithm"
        Item{
            anchors.fill: parent

            Rectangle{
                width: parent.width / 1.3
                height: parent.height / 1.3
                anchors.centerIn: parent
                radius: 5
                color: grey

                RowLayout{
                    anchors.left: parent.left
                    anchors.leftMargin: middleMargin
                    id: topRow
                    ComboBox {
                        id:startNode
                        width: comboboxSize
                        model: listModel
                        textRole: "name"
                        CustomLabel{
                            labelText: "from"
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
                        width: comboboxSize
                        model: listModel
                        textRole: "name"
                        CustomLabel{
                            labelText:"to"
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
                    spacing: 70
                    anchors.left: parent.left
                    anchors.leftMargin: middleMargin
                    Button{
                        text: "Start alrgorithm"
                        font.pixelSize: 18
                        onClicked: {
                            var shortestWay = appCore.startAlgorithmRequest(startNode.currentText, finishNode.currentText)
                            minWay.text = shortestWay
                        }
                    }
                    Text {
                        id: minWay
                    }
                    Label{
                        font.pixelSize: middlefontSize
                        anchors.bottom: minWay.top
                        anchors.left: minWay.left
                        text:"Algorithm's work result"
                    }

                }


            }
        }

    }
}
