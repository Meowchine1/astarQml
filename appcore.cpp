#include <iostream>
#include <QString>

#include "appcore.h"
#include "node.h"
#include "NodeException.h"

AppCore::AppCore(){}

bool AppCore::createNodeRequest(QString name, QString x, QString y){
    Node* node = new Node (name, x.toInt(),y.toInt());
    try{
        graph->addNode(node);
    }
    catch(NodeException ex){
        return false;
    }
    emit nodesChange({node->name,
                      QString::number(node->getX()),
                      QString::number(node->getY())});
    return true;
}

void AppCore::deleteNode(QString name){
    graph->deleteNode(name);
    emit nodesChange(getNodes());
}

void AppCore::nodeNamesRequest(){
    emit sendNodeNames(graph->getNodesNames());
}

void AppCore::readGraphFromTxtRequest(QString path){
    QString correctPath = path.split("file://").at(1);
    this->graph->readtxt(correctPath);
    emit nodesChange(getNodesNames());
}

bool AppCore::addRelationsRequest(QString from, QString to, int weight){
    try{
        graph->set_relation(from, to, weight);
        return true;
    }
    catch(NodeException& ex){
        std::cout<< ex.getMessage().toStdString();
        qDebug();
        return false;
    }
}

QString AppCore::startAlgorithmRequest(QString from, QString to){
    try{
        Node* fromNode = graph->findNodeByName(from);
        Node* toNode = graph->findNodeByName(to);
        QString minway = astar->run(fromNode, toNode, graph);
        return  minway;
    }
    catch(NodeException ex){
        std::cout << ex.getMessage().toStdString();
        return ex.getMessage();
    }
}

QVector<QString> AppCore::getNodesNames(){

    return graph->getNodesNames();
}

QVector<QVector<QString>> AppCore::getNodes(){

    return graph->getNodes();
}

QVariantList AppCore::getRelations(){

    QVector<QVector<QString> > relations =  graph->getRelations();
    QVariantList result;
    for (const auto& row : relations) {
        QVariantList rowData;
        for (const auto& cell : row) {
            result.append(cell);
        }
    }
    return result;
}

bool AppCore::deleteRelation(QString from, QString to){
    try{
        graph->deleteRelation(from,  to);
        return true;
    }
    catch(NodeException ex){
        std::cout << ex.getMessage().toStdString();
        return false;
    }
}
