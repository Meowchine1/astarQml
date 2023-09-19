#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QAbstractListModel>

class ListModel : public QAbstractListModel{
    Q_OBJECT
    enum ListRoles{
        DataRole = Qt::UserRole + 1
    };
public:
    explicit ListModel(QObject *parent = nullptr);
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
public slots:
    void loadList(QVector<QString> nodesNames);
private:
    QVector<QString> list;
};

#endif // LISTMODEL_H
