import QtQuick 2.15
import AppModule.Base 1.0

BaseListView{
    id: root
    model: ListModel{
        ListElement{
            name: "Test1"
            x_coord: 22
            y_coord: 36
        }
        ListElement{
            name: "Test2"
            x_coord: 0
            y_coord: 7
        }

    }

    delegate: AppDelegate{
        width: root.width
        height: 70

    }

}
