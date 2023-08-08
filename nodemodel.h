#ifndef NODEMODEL_H
#define NODEMODEL_H

#include <QAbstractListModel>

#include "node.h"

class NodeModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
            TextRole
        };

    explicit NodeModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override { return nodes.size; }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void addNode();
    /*
 The second is the custom method activate that we want to call from QML.
To make it callable we need to mark it with the Q_INVOKABLE macro.
*/

private:
    QVector<Node> nodes;
};

#endif // NODEMODEL_H
