import QtQuick 2.15

Rectangle {

    id: root
    color: "black"
    opacity: _delegateArea.pressed ? 0.87 : 0.5
    MouseArea{
        id: _delegateArea
        anchors.fill: root
    }
}
