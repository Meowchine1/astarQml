import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3


Page {
     id: root
     property alias backgroundColor: backgroundRect.color
     property alias buttonText: navButton.text
     signal buttonClicked();

     background: Rectangle {
        id: backgroundRect
     }

     Button {
         id: navButton
         visible: text.length > 0 // скрытие кнопки
         anchors.right: parent.right
         anchors.bottom: parent.bottom
         anchors.margins: defMargin
         onClicked: {
            root.buttonClicked();
         }
     }

     Keys.onBackPressed: {
        popPage()
     }

     Keys.onEscapePressed: {
        popPage()
     }

}
