#ifndef NODETABLEMODEL_H
#define NODETABLEMODEL_H

#include <QAbstractTableModel>

class NodeTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    enum {
            ColumnNodeName = 0,
            ColumnXCoord,
            ColumnYCoord,
            CountOfColumns
        };

    explicit NodeTableModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    QStringList m_columnNames;
};

#endif // NODETABLEMODEL_H
