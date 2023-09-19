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

ApplicationWindow {
    id: win
    width: 1000
    height: 800
    visible: true
    title: qsTr("Graph algorithm")
    // COLOR START
    Material.theme: Material.Dark
    Material.accent: Material.Pink
    Material.primary: Material.Grey
    Material.foreground: Material.Pink
    property color grey: "#dadada"
    // COLOR END
    property var repeaterFromNodes: []
    property var repeaterToNodes: []
    property int defMargin: 10
    property int defSpacing: 100
    property int middleMargin: 50
    property int btnWidth: 400
    property int fontSize: 25
    property int middlefontSize: 18
    property int nodeSize: 50
    property int comboboxSize: 400

    Component.onCompleted: {
         if (Qt.platform.os === "linux") {
             var iconPath = Qt.resolvedUrl("resourses/icon16.png");
             Qt.application.setWindowIcon(QIcon.fromUrl(iconPath));
         }
     }

    function isInt(input) {
        var intRegex = /^\d{1,10}$/
        return intRegex.test(input)
    }
    function isEmpty(input) {
        var emptyRegex = /^\s*$/
        return emptyRegex.test(input)
    }
    function popPage(){ stackView.pop(); }

    header: ToolBar{
        height: 50
        ToolButton{
            id: btnBack
            text: "<"
            font.pixelSize: 20
            visible: stackView.depth > 1
            anchors.verticalCenter: parent.verticalCenter
            onClicked:
            {
                popPage();
            }
        }
        Text {
            anchors.centerIn: parent
            font.pointSize: 16
            text: stackView.currentItem.title
        }
    }
    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: mainPage
    }



    MainPage {
        id: mainPage
    }

    RandomGraphPage {
        id: randomGraphPage
    }

    ManualCreatingPage {
        id: manualCreatingPage
    }

    ReadGraphPage {
        id: readGraphPage
    }

    RelationsPage{
        id: relationsPage
    }

    AstarPage {
        id: astarPage
    }
}
