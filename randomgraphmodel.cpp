#include "randomgraphmodel.h"
#include "strongconnection.h"


RandomGraphModel::RandomGraphModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    graph.createRandomNew();

    int x = 5;
}

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

QVariant RandomGraphModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case EmptyNode: {
        Node* node = graph.mass[index.row()][index.column()];
        return QVariant::fromValue(node->isolated);
    }
    case ActiveNode: {
        return QVariant();
    }
    }
    return QVariant();
}
