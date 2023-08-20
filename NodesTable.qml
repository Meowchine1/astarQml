import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12

import TableModel 1.0
import AppModule.Impl 1.0
import AppCore 1.0
import ListModel 1.0

Rectangle{

    id: rect


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
