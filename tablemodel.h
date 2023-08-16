#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <qqml.h>
#include <QAbstractTableModel>

#include "graph.h"

class TableModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
    QML_ADDED_IN_MINOR_VERSION(1)

    enum TableRoles{
        TableDataRole = Qt::UserRole + 1,
        HeadingRole
    };

public:
    TableModel();
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    int columnCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

signals:
    void dataChanged(const QModelIndex &topLeft, const QModelIndex &bottomRight);

public slots:
    void updateData();

private:
    Graph* graph = Graph::getInstance();
    QVector<QVector<QString>> table;
};
#endif // TABLEMODEL_H
