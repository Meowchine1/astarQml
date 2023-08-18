import QtQuick 2.15
import QtQuick.Controls 2.15 // HorizontalHeaderView
import QtQuick 2.12  //tableview
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml.Models 2.2
import QtQuick.Shapes 1.12

ApplicationWindow {
    id: win
    width: 800
    height: 480
    visible: true
    title: qsTr("Graph algorithm")




    Rectangle {
        anchors.fill: parent
        color: "red"
        opacity: 0.5

        // Список узлов графа
        ListModel {
            id: nodeModel
        }

        // Генерация случайных узлов при запуске
        Component.onCompleted: {
            for (var i = 0; i < 5; i++) {
                nodeModel.append({
                                     x: Math.random() * width,
                                     y: Math.random() * height
                                 });
            }
        }

        // Отображение узлов графа
        Repeater {
            model: nodeModel
            delegate: Rectangle {
                width: 50
                height: 50
                radius: width*0.5
                color: "black"
                x: model.x
                y: model.y
                MouseArea {
                    anchors.fill: parent
                    onClicked:{ arrowModel.append(
                                    {x: parent.x + parent.width / 2,
                                        y: parent.y + parent.height / 2
                                    })
                    }
                }
            }
        }

        // Список стрелок графа
        ListModel {
            id: arrowModel
        }
        // Отображение стрелок графа
        Repeater {
            model: arrowModel
            delegate:

                Shape {
                     ShapePath {
                         strokeColor: "red"; // it works :)
                         startX: model.x; startY: model.y
                         PathLine { x: 640; y: 480 }
                     }
            }
        }
    }
}
