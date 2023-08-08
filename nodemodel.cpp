#include "nodemodel.h"

NodeModel::NodeModel(QObject *parent)
    : QAbstractListModel(parent)
{
    nodes.append(Node{"test", 2, 3});
}

QVariant NodeModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

int NodeModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return nodes.size();
}

QVariant NodeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

     return nodes.at(index.row());
}

void NodeModel::addNode()
{
    beginInsertRows(QModelIndex(), nodes.size(), nodes.size());
    nodes.append("new");
    endInsertRows();

    nodes[0] = QString("Size: %1").arg(nodes.size());
    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}
