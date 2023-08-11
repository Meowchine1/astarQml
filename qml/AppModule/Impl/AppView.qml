import QtQuick 2.15
import AppModule.Base 1.0

BaseListView{
    id: root
    model: ListModel{
        ListElement{
            name: "Test1"
            x: "21"
            y: "36"
        }
        ListElement{
            name: "Test2"
            x: "2"
            y: "+3"
        }

    }

    delegate: AppDelegate{
        width: root.width
        height: 70

    }

}
