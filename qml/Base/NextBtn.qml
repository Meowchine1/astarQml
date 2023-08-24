
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
import CustomListModel 1.0

Button{
    text: "NEXT STEP"
    anchors.bottom: parent.bottom;
    anchors.right: parent.right
    anchors.margins: defMargin
    width: 200
    font.pixelSize: fontSize

}
