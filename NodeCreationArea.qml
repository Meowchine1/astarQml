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
