#include "listmodel.h"

ListModel::ListModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

QVariant ListModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    return "";
}

int ListModel::rowCount(const QModelIndex &parent) const
{
    return list.size();
}

QVariant ListModel::data(const QModelIndex &index, int role) const
{
    return list.at(index.row());
}

void ListModel::loadList(QVector<QString> nodesNames)
{
    list = nodesNames;
}
