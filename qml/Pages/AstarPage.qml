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
                    text: "Start algorithm"
                    font.pixelSize: 18
                    onClicked: {
                        var shortestWay = appCore.startAlgorithmRequest(startNode.currentText, finishNode.currentText)
                        minWay.text = shortestWay
                    }
                }
                Text {
                    id: minWay
                }
                Label {
                    font.pixelSize: middlefontSize
                    anchors.bottom: minWay.top
                    anchors.left: minWay.left
                    text:"Algorithm's work result"
                }
            }
        }
    }
}
