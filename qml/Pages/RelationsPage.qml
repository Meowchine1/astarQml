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
import Base 1.0

BasePage{
    id: relationsPage
    visible: false
    title: "Create node relations"
    Item{
        width: parent.width/ 2
        height: parent.height/ 2
        anchors.left: parent.left
        anchors.top: parent.top
        RowLayout{
            anchors.centerIn: parent
            ComboBox {
                id:comboboxFrom
                width: comboboxSize
                model: listModel
                textRole: "name"

                CustomLabel {
                    anchors.bottom: parent.top
                    labelText: "from"
                }
            }
            ComboBox {
                id:comboboxTo
                width: comboboxSize
                model: listModel
                textRole: "name"
                CustomLabel {
                    labelText: "to"
                    anchors.bottom: parent.top
                }
            }
        }
    }
    Item{
        width: parent.width/ 2
        height: parent.height/ 2
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: middleMargin
        DialogItem {
            id: messageDialog
            z:1
            visible: false
            buttons: ['Ok']
            dialog_width: parent.width
            dialog_height: parent.height
            anchors.centerIn: parent
            color: "grey"
            onClicked: visible = false
        }
        ColumnLayout{
            anchors.top: parent.top
            anchors.centerIn: parent
            CustomInputField{
                id: weight
                fieldWidth: 200
                placeholderText: "Enter edge weight"
            }
            Button{
                text: "Add relation"
                implicitWidth: 200
                font.pixelSize: middlefontSize
                onClicked: {
                    if(isInt(weight.text)){
                        var from = comboboxFrom.currentText
                        var to = comboboxTo.currentText
                        var fromCoordinates = getCoordinatesFromNodeByText(from)
                        var toCoordinates = getCoordinatesToNodeByText(to)
                        if(appCore.addRelationsRequest(from, to, weight.text)){
                            if (fromCoordinates && toCoordinates) {
                                arrowModel.append({ x: fromCoordinates.x, y: fromCoordinates.y,
                                                      targetX: toCoordinates.x, targetY: toCoordinates.y })
                            }
                        }else{
                            messageDialog.text = 'Relation between ' + from + ' and ' + to + " already exist";
                            messageDialog.visible = true
                        }
                    }else{
                        messageDialog.text = 'Weight should be an Integer value'
                        messageDialog.visible = true
                    }
                }
            }

            Button{
                id: deleteRelation
                text:"Delete relation"
                implicitWidth: 200
                font.pixelSize: middlefontSize
                onClicked: {
                    var from = comboboxFrom.currentText
                    var to = comboboxTo.currentText

                    var fromCoordinates = getCoordinatesFromNodeByText(from)
                    var toCoordinates = getCoordinatesToNodeByText(to)

                    if(appCore.deleteRelation(from, to)){
                        for(var i = 0; i < arrowModel.count; i++) {
                            if (arrowModel.get(i).x === fromCoordinates.x
                                    && arrowModel.get(i).y === fromCoordinates.y
                                    && arrowModel.get(i).targetX === toCoordinates.x
                                    && arrowModel.get(i).targetY === toCoordinates.y){
                                arrowModel.remove(arrowModel.get(i))
                            }
                        }
                    }else{
                        messageDialog.text = 'Relation between ' + from + ' and ' + to + " unexist";
                        messageDialog.visible = true
                    }
                }
            }

            Button{
                implicitWidth: 200
                font.pixelSize: 12
                text:"Загрузить отношения"
                onClicked: {
                    var relations = appCore.getRelations();
                    for(var i = 0; i < relations.length; i+=2){
                        var from = relations[i]
                        var to = relations[i+1]
                        var fromCoordinates = getCoordinatesFromNodeByText(from)
                        var toCoordinates = getCoordinatesToNodeByText(to)
                        arrowModel.append({ x: fromCoordinates.x, y: fromCoordinates.y,
                                              targetX: toCoordinates.x, targetY: toCoordinates.y })
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
        anchors.margins: defMargin
        border.width: 2
        border.color: borderColor
        radius: radiusValue

        RowLayout{
            spacing: parent.width / 1.5
            anchors.top: parent.horizontalCenter
            anchors.margins: middleMargin

            ColumnLayout{ // Отображение узлов графа
                Repeater {
                    id: fromNodes
                    model: listModel
                    delegate: Rectangle {
                        width: nodeSize
                        height: nodeSize
                        radius: width*0.5
                        color: grey
                        opacity: 0.5
                        Text{
                            anchors.centerIn: parent
                            text: model["name"]
                            color: Qt.lighter(grey)
                            font.pixelSize: fontSize
                            elide: Text.ElideRight
                            width: parent.width
                            Component.onCompleted: {
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
                        id: rect
                        width: nodeSize
                        height: nodeSize
                        radius: width*0.5
                        color: grey
                        opacity: 0.5

                        Text{
                            id: nodeText
                            anchors.centerIn: rect
                            text: model["name"]
                            font.pixelSize: fontSize
                            color: Qt.lighter(grey)
                            elide: Text.ElideRight
                            width: parent.width
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
                            ctx.arc(model.targetX, model.targetY, 5, 0, 2 * Math.PI)
                            ctx.fill();
                        }
                    }
                }
            }
        }
    }
    NextBtn{
        onClicked: {
            stackView.push(astarPage)
        }
    }
    function findFromNodeByText(text) {
        for (var i = 0; i < win.repeaterFromNodes.length; i++) {
            if (win.repeaterFromNodes[i].text === text) {
                return win.repeaterFromNodes[i].item
            }
        }
        return null
    }

    function findToNodeByText(text) {
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
            itemPosition.x += item.width
            itemPosition.y += item.height / 2
            return {x: itemPosition.x, y: itemPosition.y}
        }
        return null
    }

    function getCoordinatesToNodeByText(text) {
        var item = findToNodeByText(text)
        if (item !== null) {
            var itemPosition = item.mapToItem(graphWin, 0, 0)
            itemPosition.y += item.height  / 2
            return {x: itemPosition.x, y: itemPosition.y}
        }
        else{
            console.warn("Null")
        }
        return null
    }
}
