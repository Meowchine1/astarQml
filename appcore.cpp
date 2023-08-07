#include <QString>

#include "appcore.h"
#include "node.h"

AppCore::AppCore()
{

}

void AppCore::createNodeRequest(QString name, QString x, QString y)
{

    // to do проверка полей x y
    Node node(name, x.toInt(),y.toInt());
    graph.addNode(&node);
    emit sendGraph(&graph);
}

void AppCore::readGraphFromTxtRequest(std::string path)
{
    this->graph.readtxt(path);
    emit sendGraph(&graph);
}



void AppCore::addRelationsRequest(Node* from, Node* to, int weight)
{
    graph.set_relation(from, to, weight);
    emit sendGraph(&graph);
}
