import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12

import TableModel 1.0
import AppModule.Impl 1.0
import AppCore 1.0
import ListModel 1.0


ApplicationWindow {
    id: win
    width: 800
    height: 480
    visible: true
    title: qsTr("Graph algorithm")
    property var repeaterFromNodes: []
    property var repeaterToNodes: []



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

            id: rect
            width: parent.width / 2
            height: parent.height / 2
            //anchors.fill: parent
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: defMargin

            TableView{
                id: tableview
                anchors.fill: parent // не заполняет родителя
                columnSpacing: 3 // увеличить
                rowSpacing: 1
                clip: true

                model: tableModel

                delegate: Rectangle{
                    border.color: "black"
                    border.width: 2
                    implicitWidth: rect.width / 3
                    implicitHeight: 50
                    color: (heading == true)? "grey" : "white"
                    Text{
                        anchors.centerIn: parent
                        text: tabledata
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
        }

        Rectangle{
            id: createNodeBtn
            width: parent.width / 3
            height: parent.height / 2
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: defMargin
            color: "pink"

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

                Button {
                    text: "Add node to graph"
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    onClicked: {
                        appCore.createNodeRequest(nameField.text,
                                                  coordinateX.text,
                                                  coordinateY.text)
                        nameField.text = ""
                        coordinateX.text = ""
                        coordinateY.text = ""
                    }
                }
            }
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
                    StackView.push(relationsPage)
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
            console.warn("Canceled")
            Qt.quit()
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*                                               NEW PAGE                                                    */
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function findFromNodeByText(text) {
        console.warn("FROM: ", text)
        for (var i = 0; i < win.repeaterFromNodes.length; i++) {
            if (win.repeaterFromNodes[i].text === text) {
                return win.repeaterFromNodes[i].item
            }
        }
        return null
    }

    function findToNodeByText(text) {

        console.warn("TO: ", text)
        for (var i = 0; i < win.repeaterToNodes.length; i++) {
            if (win.repeaterToNodes[i].text === text) {
                return win.repeaterToNodes[i].item
            }
        }
        return null
    }


    function getCoordinatesFromNodeByText(text) {
        var item = findFromNodeByText(text)
        if (item !== null) {
            var itemPosition = item.mapToItem(graphWin, 0, 0)
            console.warn("FROM X = ", itemPosition.x)
            console.warn("FROM Y = ", itemPosition.y)
            return {x: itemPosition.x + item.width / 2, y: itemPosition.y + item.height / 2}
        }
        return null
    }

    function getCoordinatesToNodeByText(text) {
        var item = findToNodeByText(text)
        if (item !== null) {
            var itemPosition = item.mapToItem(graphWin, 0, 0)
            console.warn("TO X = ", itemPosition.x + item.width / 2)
            console.warn("TO Y = ", itemPosition.y + item.height / 2)
            return {x: itemPosition.x  + item.width / 2  , y: itemPosition.y + item.height / 2 }
        }
        return null
    }

    BasePage{
        id:relationsPage
        visible: false
        Rectangle{
            width: parent.width/ 2
            height: parent.height/ 2
            anchors.left: parent.left
            anchors.top: parent.top
            RowLayout{
                anchors.centerIn: parent
                spacing: 20
                ComboBox {
                    id:comboboxFrom
                    width: 200
                    model: listModel
                    textRole: "name"
                    Label{
                        text:"from"
                        anchors.bottom: parent.top
                    }

                }
                ComboBox {
                    id:comboboxTo
                    width: 200
                    model: listModel
                    textRole: "name"
                    Label{
                        text:"to"
                        anchors.bottom: parent.top
                    }
                }
            }
        }
        Rectangle{
            width: parent.width/ 2
            height: parent.height/ 2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 200
            ColumnLayout{
                anchors.top: parent.top
                spacing: 20
                CustomInputField{
                    id: weight
                    name: "Enter edge weight"
                }
                Button{
                    text: "Add relation"
                    onClicked: {
                        var from = comboboxFrom.currentText
                        var to = comboboxTo.currentText
                        var fromCoordinates = getCoordinatesFromNodeByText(from)
                        var toCoordinates = getCoordinatesToNodeByText(to)
                        appCore.addRelationsRequest(from, to, weight.text)
                        if (fromCoordinates && toCoordinates) {

                            arrowModel.insert({ x: fromCoordinates.x, y: fromCoordinates.y,
                                            xTarget: toCoordinates.x, yTarget: toCoordinates.y })

//                            arrowModel: [
//                            { x: fromCoordinates.x, y: fromCoordinates.y,
//                                xTarget: toCoordinates.x, yTarget: toCoordinates.y }
//                            ]
                        }
                    }
                }
            }
        }
        Rectangle {
            id: graphWin
            width: parent.width/ 2
            height: parent.height/ 1.2
            anchors.right: parent.right
            anchors.top: parent.top
            color: "red"
            opacity: 0.5
            RowLayout{
                spacing: parent.width / 1.5
                anchors.top: parent.horizontalCenter
                ColumnLayout{ // Отображение узлов графа
                    anchors.margins: defMargin
                    Repeater {
                        id: fromNodes
                        model: listModel
                        delegate: Rectangle {
                            width: 50
                            height: 50
                            radius: width*0.5
                            color: "black"
                            Text{
                                anchors.centerIn: parent
                                text: model["name"]
                                Component.onCompleted: {
                                    // Сохраняем элементы Repeater
                                    win.repeaterFromNodes.push({text: text, item: fromNodes.itemAt(index)})
                                }
                            }
                        }
                    }
                }
                ColumnLayout{ // Отображение узлов графа
                    Repeater {
                        id: toNodes
                        model: listModel
                        delegate: Rectangle {
                            width: 50
                            height: 50
                            radius: width*0.5
                            color: "black"
                            Text{
                                anchors.centerIn: parent
                                text: model["name"]
                                Component.onCompleted: {
                                    win.repeaterToNodes.push({text: text, item: toNodes.itemAt(index)})
                                }
                            }
                        }
                    }
                }
                ListModel {  // Список стрелок графа
                    id: arrowModel
                }
                Repeater { // Отображение стрелок графа
                    model: arrowModel
                    delegate:
                        Shape {
                        ShapePath {
                            strokeColor: "black";
                            startX: model.x; startY: model.y
                            PathLine { x: model.xTarget; y: model.yTarget }
                        }
                    }
                }
            }
        }
        Button{
            text: "NEXT STEP"
            anchors.bottom: parent.bottom;
            anchors.right: parent.right
            anchors.margins: defMargin
            onClicked: {
                stackView.push()

            }
        }
    }
}
