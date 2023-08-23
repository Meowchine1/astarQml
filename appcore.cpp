#include <iostream>
#include <QString>

#include "appcore.h"
#include "node.h"

AppCore::AppCore(){}

bool AppCore::createNodeRequest(QString name, QString x, QString y)
{
        Node* node = new Node (name, x.toInt(),y.toInt());
        try{
            graph->addNode(node);

        }
        catch(...){
            return false;
        }

        emit nodesChange({node->name,
                          QString::number(node->getX()),
                          QString::number(node->getY())});
        return true;

}

void AppCore::deleteNode(QString name)
{

    graph->deleteNode(name);

 emit nodesChange(getNodes());
}

void AppCore::nodeNamesRequest()
{
  emit sendNodeNames(graph->getNodesNames());
}

void AppCore::readGraphFromTxtRequest(QString path)
{

    QString correctPath = path.split("file://").at(1);
    this->graph->readtxt(correctPath);
    emit nodesChange(getNodes());
}

bool AppCore::addRelationsRequest(QString from, QString to, int weight)
{
    try{
        Node* fromNode = graph->findNodeByName(from);
        Node* toNode = graph->findNodeByName(to);
        graph->set_relation(fromNode, toNode, weight);
        return true;
    }
    catch(...){
        return false;
    }

}

QString AppCore::startAlgorithmRequest(QString from, QString to)
{
    try{
        Node* fromNode = graph->findNodeByName(from);
        Node* toNode = graph->findNodeByName(to);
        QString minway = astar->run(fromNode, toNode, graph);
        return  minway;
    }
    catch(...){
        return "null";
    }
}

QVector<QString> AppCore::getNodes(){

    return graph->getNodesNames();
}

QVector<QVector<QString> > AppCore::getRelations()
{
    return graph->getRelations();
}

void AppCore::deleteRelation(QString from, QString to)
{
    graph->deleteRelation(from,  to);
}
