import QtQuick 2.15
import AppModule.Base 1.0

BaseListDelegate {
    id: root

    Column{
        
        
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        anchors.leftMargin: 20
        Row{

            spacing: 12
            BaseText{

                text: name
            }
            BaseText{

                text: x
            }
            BaseText{

                text: y
            }
        }
    }

}
