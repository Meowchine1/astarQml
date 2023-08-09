#ifndef NODELIST_H
#define NODELIST_H

#include <QObject>

#include "node.h"

class NodeList : public QObject
{
    Q_OBJECT
public:
    explicit NodeList(QObject *parent = nullptr);

private:
    QVector<Node> nodes;

signals:

};

#endif // NODELIST_H
