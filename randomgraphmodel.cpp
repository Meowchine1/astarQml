#include "randomgraphmodel.h"

RandomGraphModel::RandomGraphModel(QObject *parent)
    : QAbstractTableModel(parent){}

QVariant RandomGraphModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    return QVariant();
}

int RandomGraphModel::rowCount(const QModelIndex &parent) const
{
    return N;
}

int RandomGraphModel::columnCount(const QModelIndex &parent) const
{
    return N;
}

QHash<int, QByteArray> RandomGraphModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[EmptyNode] = "emptyNode";
    roles[ActiveNode] = "activeNode";
    return roles;
}

void RandomGraphModel::resetGraph()
{
    beginResetModel();
    graph->reset();
    endResetModel();
}

QVariant RandomGraphModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case EmptyNode:{
        Node* node = graph->getNode(index.row(), index.column());
        return QVariant::fromValue(node->isolated);
    }
    case ActiveNode: {
        return QVariant();
    }
    }
    return QVariant();
}
