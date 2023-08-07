#ifndef APPCORE_H
#define APPCORE_H
#include <QObject>
#include <QString>
#include "node.h"
#include "graph.h"

class AppCore  : public QObject
{
    Q_OBJECT

public:
    AppCore();
    Graph graph;

signals:
    void sendGraph(Graph* graph);

public slots:
    void createNodeRequest(QString name, QString x, QString y);
    void readGraphFromTxtRequest(std::string path);
    void addRelationsRequest(Node* from, Node* to, int weight);
};

#endif // APPCORE_H
