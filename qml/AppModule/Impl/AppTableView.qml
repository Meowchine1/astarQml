import QtQuick 2.15
import AppModule.Base 1.0
import Qt.labs.qmlmodels 1.0

BaseTableView{

model: TableModel {
    TableModelColumn { display: "name" }
    TableModelColumn { display: "color" }

    rows: [
        {
            "name": "cat",
            "color": "black"
        },
        {
            "name": "dog",
            "color": "brown"
        },
        {
            "name": "bird",
            "color": "white"
        }
    ]
}

delegate:  AppTableDelegate{}

}
