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
                    stackView.push(relationsPage)
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

        console.warn("len: ", win.repeaterToNodes.length)
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
            return {x: itemPosition.x + item.width /* / 2 */, y: itemPosition.y + item.height / 2 }
        }
        return null
    }

    function getCoordinatesToNodeByText(text) {
        var item = findToNodeByText(text)
        if (item !== null) {
            var itemPosition = item.mapToItem(graphWin, 0, 0)
            console.warn("TO X = ", itemPosition.x + item.width / 2)
            console.warn("TO Y = ", itemPosition.y + item.height / 2)
            return {x: itemPosition.x /* + item.width  / 2 */  , y: itemPosition.y + item.height  / 2 }
        }
        else{
            console.warn("Null")
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
            anchors.leftMargin: middleMargin

            DialogItem {
                id: messageDialog
                z:1
                visible: false
                buttons: ['Ok']
                dialog_width: parent.width / 2
                dialog_height: parent.height / 2
                anchors.centerIn: parent
                color: "grey"
                onClicked: visible = false
            }

            ColumnLayout{
                anchors.top: parent.top
                spacing: 20
                anchors.centerIn: parent
                CustomInputField{
                    id: weight
                    name: "Enter edge weight"
                }
                Button{
                    text: "Add relation"
                    onClicked: {
                        if(isInt(weight.text)){

                            var from = comboboxFrom.currentText
                            var to = comboboxTo.currentText
                            var fromCoordinates = getCoordinatesFromNodeByText(from)
                            var toCoordinates = getCoordinatesToNodeByText(to)
                            appCore.addRelationsRequest(from, to, weight.text)
                            if (fromCoordinates && toCoordinates) {

                                arrowModel.append({ x: fromCoordinates.x, y: fromCoordinates.y,
                                                      targetX: toCoordinates.x, targetY: toCoordinates.y })
                            }
                        }
                        else{
                            messageDialog.text = 'Weight should be an Integer value'
                            messageDialog.visible = true
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
                            opacity: 0.5
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
                    anchors.margins: defMargin
                    Repeater {
                        id: toNodes
                        model: listModel
                        delegate: Rectangle {
                            z:1
                            width: 50
                            height: 50
                            radius: width*0.5
                            color: "black"
                            opacity: 0.5
                            Text{
                                anchors.centerIn: parent
                                text: model["name"]
                                Component.onCompleted: {
                                    // Сохраняем элементы Repeater
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

                        Item {

                        Canvas {
                            id: canvas
                            antialiasing: true
                            width: win.width
                            height: win.height
                            onPaint: {
                                var ctx = canvas.getContext('2d')
                                ctx.strokeStyle = "#000000"
                                ctx.lineCap = "round"
                                ctx.lineWidth = canvas.height * 0.009
                                ctx.beginPath()
                                ctx.moveTo(model.x, model.y)
                                ctx.lineTo(model.targetX, model.targetY)
                                ctx.stroke()
                                ctx.moveTo(model.targetX, model.targetY)
                                ctx.arc(model.targetX, model.targetY, 10, 0, 2 * Math.PI)
                                ctx.fill();
                            }
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
                stackView.push(astarPage)

            }
        }
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
