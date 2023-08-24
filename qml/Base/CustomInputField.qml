import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

Item{

    property alias name: fieldName.text
    property alias placeholderText: innerText.placeholderText
    property alias text: innerText.text
    property alias readonly: innerText.readOnly
    property alias fieldWidth: innerText.width
    Layout.preferredWidth: 40
    Layout.preferredHeight: 40

    Label{
        id: fieldName
        anchors.right: innerText.left
        anchors.rightMargin: defMargin
        anchors.verticalCenter: innerText.verticalCenter
        font.pixelSize: 25
    }
    TextField{
        id: innerText
        width: win.width / 3

    }
}
