#ifndef DATATABLE_H
#define DATATABLE_H
#include <QObject>


class DataTable : public QObject {
    Q_OBJECT


public slots:
    void setTableData(const QVariantList& data);
};

#endif // DATATABLE_H
