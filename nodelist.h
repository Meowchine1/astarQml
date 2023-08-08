#ifndef NODELIST_H
#define NODELIST_H

#include <QObject>

class NodeList : public QObject
{
    Q_OBJECT
public:
    explicit NodeList(QObject *parent = nullptr);

signals:

};

#endif // NODELIST_H
