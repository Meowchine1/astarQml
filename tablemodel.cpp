#include "tablemodel.h"


TableModel::TableModel()
{
    table = graph->getNodes();
//    table.append({"A", QString::number(4), QString::number(45)});
//    table.append({"B", QString::number(66), QString::number(8)});
//    table.append({"C", QString::number(-8), QString::number(1)});
}


int TableModel::rowCount(const QModelIndex &) const
{
    return table.size();
}

int TableModel::columnCount(const QModelIndex &) const
{
    return table.at(0).size();
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    switch(role){
    case TableDataRole:
    {
        return table.at(index.row()).at(index.column());
    }
    case HeadingRole:
    {
        if(index.row() == 0){
            return true;
        }else{
            return false;
        }
    }
    default:{ break; }
    }
    return QVariant();
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TableDataRole] = "tabledata";
    roles[HeadingRole] = "heading";
    return roles;
}

void TableModel::updateData()
{
    table.clear();
    table = graph->getNodes();
   // beginResetModel();

    emit dataChanged(index(0,0), index(table.size() - 1, table.at(0).size() - 1));
    //endResetModel();

}


