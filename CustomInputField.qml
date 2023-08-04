import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

Rectangle{

    property alias fieldName: fieldName.text
    property alias placeholderText: innerText.placeholderText
    property alias text: innerText.text

    Layout.preferredWidth: 40
    Layout.preferredHeight: 40

    Label{
        id: fieldName
        anchors.right: innerText.left
        anchors.margins: defMargin
    }
    TextField{
        id: innerText
    }
}
