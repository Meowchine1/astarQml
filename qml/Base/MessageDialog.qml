import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12
import QtQuick.Controls.Material 2.12
import org.kde.kirigami 2.9 as Kirigami

import AppCore 1.0
import RandomModel 1.0
import Base 1.0

Dialog {
    property alias dialogTitle: messageDialog.title
    property alias message: content.text

    id: messageDialog
    width: win.width / 3
    height: win.height / 4
    standardButtons: Dialog.Ok
    contentItem: Item{
        Rectangle{
            id: border
            radius: 5
            border.color: "grey"
            border.width: 2
            width: messageDialog.width * 0.9
            height: messageDialog.height * 0.9
            color: Kirigami.Theme.backgroundColor
            anchors.centerIn: parent
            anchors.margins: defMargin
            Text {
                id: content
                anchors.left: border.left
                anchors.top: border.top
                anchors.margins: defMargin
            }
            Rectangle {
                id: dividerHorizontal
                color: "grey"
                width: border.width
                height: 2 // Устанавливаем ширину в два пикселя
                anchors.left: border.left
                anchors.bottom: button.top
                anchors.bottomMargin: defMargin
            }
            Rectangle{
                id: button
                width: border.width * 0.3
                height: border.height * 0.2
                anchors.bottom: border.bottom
                anchors.bottomMargin: defMargin
                anchors.horizontalCenter: border.horizontalCenter
                border.width: 2
                focus: true
                border.color: mouseArea.containsMouse ? focusedBorderColor : borderColor
                radius: 5
                MouseArea{
                    id: mouseArea
                    hoverEnabled: true
                    anchors.fill: button
                }

                RowLayout{
                    anchors.centerIn: button
                    Image {
                        source: "qrc:resourses/ok.png"
                    }
                    Text {
                        text: "Ok"
                    }
                }
                MouseArea{
                    anchors.fill: button
                    onClicked: messageDialog.accept()
                }
            }
        }
    }
    onAccepted: {
        console.warn("Ok button clicked " + messageDialog.result);
    }
}
