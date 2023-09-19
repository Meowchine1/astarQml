#include "listmodel.h"

ListModel::ListModel(QObject *parent)
    : QAbstractListModel(parent){}

QVariant ListModel::headerData(int section, Qt::Orientation orientation, int role) const{
    return "";
}

QHash<int, QByteArray> ListModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[DataRole] = "name";
    return roles;
}

int ListModel::rowCount(const QModelIndex &parent) const{
    return list.size();
}

QVariant ListModel::data(const QModelIndex &index, int role) const{
    if (role == DataRole) {
          return list.at(index.row());
      }
      return QVariant();
}

void ListModel::loadList(QVector<QString> nodesNames){
    beginResetModel();
    list = nodesNames;
    endResetModel();
}
