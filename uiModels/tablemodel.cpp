#include "tablemodel.h"

TableModel::TableModel(){}

int TableModel::rowCount(const QModelIndex &) const{
    return table.size();
}

int TableModel::columnCount(const QModelIndex &) const{
    return table.at(0).size();
}

QVariant TableModel::data(const QModelIndex &index, int role) const{
    switch(role){
    case TableDataRole:{
        return table.at(index.row()).at(index.column());
    }
    case HeadingRole:{
        return index.row() == 0;
    }
    default:{ break; }
    }
    return QVariant();
}

QHash<int, QByteArray> TableModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[TableDataRole] = "tabledata";
    roles[HeadingRole] = "heading";
    return roles;
}

QString TableModel::getProperty(const QModelIndex &index){
    return table.at(index.row()).at(index.column());
}

void TableModel::updateData(QVector<QString> node){
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    table.append(node);
    endInsertRows();
}

void TableModel::updateData(QVector<QVector<QString> > node){
    int tlast = table.size() - 1;
    beginResetModel();

    if (tlast > 1){
         table.remove(1,  tlast);
    }else{
        table.remove(1);
    }

    if(!node.empty()){
        table.append(node);
    }
    endResetModel();
}


