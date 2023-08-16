#ifndef APPCORE_H
#define APPCORE_H
#include <QObject>
#include <QString>
#include <qqml.h>

#include "node.h"
#include "graph.h"

class AppCore  : public QObject
{
    Q_OBJECT

public:
    AppCore();
    Graph* graph = Graph::getInstance();
    QStringList getNodes();
    QString filepath;

    void setPath(){}

signals:
    void nodesChange(QStringList nodes);

public slots:
    void createNodeRequest(QString name, QString x, QString y);
    void readGraphFromTxtRequest(QString path);
    void addRelationsRequest(QString from, QString to, int weight);
};

#endif // APPCORE_H
