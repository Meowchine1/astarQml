#include "nodetablemodel.h"

NodeTableModel::NodeTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    m_columnNames << tr("Name") << tr("X") << tr("Y");
}

QVariant NodeTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation != Qt::Horizontal || role != Qt::DisplayRole || section >= columnCount())
            return QVariant();

        return m_columnNames.at(section);
}

int NodeTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return 20;
}

int NodeTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return CountOfColumns;
}

QVariant NodeTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    int row = index.row();
    int col = index.column();

    if (row >= rowCount() || col >= columnCount() || role !=  Qt::DisplayRole)
        return QVariant();

    switch (col)
    {
    case ColumnNodeName:
        return QString("Multicast %1").arg(row + 1 /*, 2, QChar('0')*/);
    case ColumnXCoord:
        return row;
    case ColumnYCoord:
        return row;
    }


    return QVariant();
}
