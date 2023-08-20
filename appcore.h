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
    QVector<QVector<QString>> getNodes();
    QString filepath;

    void setPath(){}



signals:
    void nodesChange(QVector<QString> nodes);
    void nodesChange(QVector<QVector<QString>> nodes);
    void sendNodeNames(QVector<QString> nodes);

public slots:
    void createNodeRequest(QString name, QString x, QString y);
    void nodeNamesRequest();
    void readGraphFromTxtRequest(QString path);
    bool addRelationsRequest(QString from, QString to, int weight);
    QString startAlgorithmRequest(QString from, QString to);

};

#endif // APPCORE_H
