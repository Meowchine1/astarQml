#ifndef RADOMGRAPHMODEL_H
#define RADOMGRAPHMODEL_H

#include <QAbstractTableModel>
#include<QVector>

#include "application/node.h"
#include "application/strongconnection.h"
class RandomGraphModel : public QAbstractTableModel
{
    Q_OBJECT

    enum TableRoles{
        EmptyNode = Qt::UserRole + 1,
        ActiveNode
    };

public:
    explicit RandomGraphModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE
    void resetGraph();

    Q_INVOKABLE
    void emptyGraph();

    Q_INVOKABLE
    void addEmptyNode(int i, int j);

    Q_INVOKABLE
    void deleteEmptyNode(int i, int j);

private:
    StrongConnection* graph = StrongConnection::getInstance();
};

#endif // RADOMGRAPHMODEL_H
