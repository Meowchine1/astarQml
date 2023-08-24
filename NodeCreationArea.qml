import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import Qt.labs.platform 1.1


Item {
    id: createNodeBtn

    ColumnLayout {
       // anchors.fill:parent

        CustomInputField {
            id: nameField
            placeholderText: "Node name"
            //name: "Node name"

        }
        CustomInputField {
            id: coordinateX
            placeholderText: "Coordinate X"
            //name: "Coordinate X"
        }
        CustomInputField {
            id: coordinateY
            placeholderText: "Coordinate Y"
            //name: "Coordinate Y"
        }

        Button {
            text: "Add node to graph"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            font.pixelSize: middlefontSize
            onClicked: {

                if(isEmpty(nameField.text) | isEmpty(coordinateX.text) | isEmpty(coordinateY.text))
                {
                    messageDialog.text = 'Fill input all fields'
                    messageDialog.visible = true
                }
                else{
                    if (isInt(coordinateX.text) && isInt(coordinateY.text)) {
                        if(appCore.createNodeRequest(nameField.text, coordinateX.text, coordinateY.text)){
                        nameField.text = ""; coordinateX.text = ""; coordinateY.text = "";
                        }
                        else{
                            messageDialog.text = "Node with name " + nameField.text + " already exist"
                            messageDialog.visible = true
                        }


                    } else {
                        messageDialog.text = 'Corrdonates should be an Integer value'
                        messageDialog.visible = true
                    }
                }

            }
        }
    }

    DialogItem {
        id: messageDialog
        visible: false
        buttons: ['Ok']
        dialog_width: parent.width
        dialog_height: parent.height
        color: "grey"

        anchors.centerIn: parent

        onClicked: visible = false
    }


}
