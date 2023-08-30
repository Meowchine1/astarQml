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
        anchors.topMargin: middleMargin
        anchors.leftMargin: middleMargin
        width: parent.width / 2
        height: parent.height / 2

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
