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

BasePage {
    id: mainPage
    title: "Main page"
    Rectangle{
        width: parent.width /2
        height: parent.height /2
        border.color: borderColor
        border.width: 2
        radius: radiusValue
        anchors.centerIn: parent
        ColumnLayout{
            anchors.centerIn: parent
            Button{
                id: randombtn
                Layout.fillWidth: true
                Layout.preferredWidth: btnWidth
                font.pixelSize: fontSize
                text: "Random generation"
                onClicked: {
                    stackView.push(randomGraphPage)
                }
            }
            Button{
                id: manualbtn
                Layout.fillWidth: true
                Layout.preferredWidth: btnWidth
                font.pixelSize: fontSize
                text: "Manual creating"

                onClicked: {
                    stackView.push(manualCreatingPage)
                }
            }
            Button{
                id: readbtn
                Layout.fillWidth: true
                Layout.preferredWidth: btnWidth
                font.pixelSize: fontSize
                text: "Read txt file"
                onClicked: {
                    stackView.push(readGraphPage)
                }
            }
            Button{
                id: exitbtn
                Layout.fillWidth: true
                Layout.preferredWidth: btnWidth
                font.pixelSize: fontSize
                text: "Exit"
                onClicked: {
                    win.close()
                }
            }
        }
    }

}
