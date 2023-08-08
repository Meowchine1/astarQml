#include <iostream>
#include <QString>
#include "appcore.h"
#include "node.h"

AppCore::AppCore(){}

void AppCore::createNodeRequest(QString name, QString x, QString y)
{
    // to do проверка полей x y
    Node node(name, x.toInt(),y.toInt());
    graph.addNode(&node);
    emit sendNodes(getNodes());
}

void AppCore::readGraphFromTxtRequest(QString path)
{
    this->graph.readtxt(path);
    emit sendNodes(getNodes());
}

void AppCore::addRelationsRequest(QString from, QString to, int weight)
{
    try{
    Node* fromNode = graph.findNodeByName(from);
    Node* toNode = graph.findNodeByName(to);
    graph.set_relation(fromNode, toNode, weight);
    }
    catch(const char* error_message){

        std::cout << error_message << std::endl;
    }
}


QStringList AppCore::getNodes(){

    QStringList result;

    for (auto elem : graph.nodes){
        QString tmp = elem->name +
                " x=" + QString::number(elem->getX()) + " y=" + QString::number(elem->getY());
        result.append(tmp);
    }
    return result;

}
