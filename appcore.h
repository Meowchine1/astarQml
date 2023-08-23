#ifndef APPCORE_H
#define APPCORE_H
#include <QObject>
#include <QString>
#include <qqml.h>

#include "node.h"
#include "graph.h"
#include "astar.h"

class AppCore  : public QObject
{
    Q_OBJECT

public:
    AppCore();
    Graph* graph = Graph::getInstance();
    Astar* astar = new Astar();

    QString filepath;

    void setPath(){}

    Q_INVOKABLE
    QVector<QString> getNodes();
    Q_INVOKABLE
    QVariantList getRelations();
    Q_INVOKABLE
    void deleteRelation(QString from, QString to);

signals:
    void nodesChange(QVector<QString> nodes);
    void nodesChange(QVector<QVector<QString>> nodes);
    void sendNodeNames(QVector<QString> nodes);

public slots:
    bool createNodeRequest(QString name, QString x, QString y);
    void deleteNode(QString name);
    void nodeNamesRequest();
    void readGraphFromTxtRequest(QString path);
    bool addRelationsRequest(QString from, QString to, int weight);
    QString startAlgorithmRequest(QString from, QString to);

};

#endif // APPCORE_H


