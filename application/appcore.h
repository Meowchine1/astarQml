#ifndef APPCORE_H
#define APPCORE_H
#include <QObject>
#include <QString>
#include <qqml.h>

#include "node.h"
#include "graph.h"
#include "astar.h"
#include "strongconnection.h"

class AppCore  : public QObject{
    Q_OBJECT

public:
    AppCore();
    Graph* graph = Graph::getInstance();
    StrongConnection* randomGraph = StrongConnection::getInstance();
    Astar* astar = new Astar();
    QString filepath;
    void setPath(){}
    QVector<QString> getNodesNames();
    Q_INVOKABLE
    QVector<QVector<QString> > getNodes();
    Q_INVOKABLE
    QVariantList getRelations();
    Q_INVOKABLE
    bool deleteRelation(QString from, QString to);

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
    QVariantList startAlgorithmWithAutogeneratedGraph(int start_x, int start_y, int finish_x, int finish_y);
};

#endif // APPCORE_H

