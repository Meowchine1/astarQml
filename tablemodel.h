#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <qqml.h>
#include <QAbstractTableModel>

class TableModel : public QAbstractTableModel{
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

    Q_INVOKABLE
    QString getProperty(const QModelIndex &index);

public slots:
    void updateData(QVector<QString> node);
    void updateData(QVector<QVector<QString>> node);
private:
    QVector<QVector<QString>> table = {{"Node name", "Coordinate X", "Coordinate Y"}};
    QString name;
};
#endif // TABLEMODEL_H
