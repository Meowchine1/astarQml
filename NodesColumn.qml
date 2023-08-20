import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.12

import TableModel 1.0
import AppModule.Impl 1.0
import AppCore 1.0
import ListModel 1.0


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
