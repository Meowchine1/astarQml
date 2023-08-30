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
import RandomModel 1.0
import Base 1.0
import Pages 1.0

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
                stackView.push(relationsPage)
                appCore.nodeNamesRequest()
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
}
