#include <iostream>
#include <QString>

#include "appcore.h"
#include "node.h"

AppCore::AppCore(){}

void AppCore::createNodeRequest(QString name, QString x, QString y)
{
    QRegExp consistFromDidgits("\\d*");

    if(consistFromDidgits.exactMatch(x) && consistFromDidgits.exactMatch(y)){

        Node* node = new Node (name, x.toInt(),y.toInt());
        try{
            graph->addNode(node);
        }
        catch(const char* error_message){

            std::cout << error_message << std::endl;
        }

        emit nodesChange({node->name,
                          QString::number(node->getX()),
                          QString::number(node->getY())});
    }
    else{

        //to do error message
        //
    }

}

void AppCore::nodeNamesRequest()
{
  emit sendNodeNames(graph->getNodesNames());
}

void AppCore::readGraphFromTxtRequest(QString path)
{
    this->graph->readtxt(path);
    emit nodesChange(getNodes());
}

void AppCore::addRelationsRequest(QString from, QString to, int weight)
{
    try{
        Node* fromNode = graph->findNodeByName(from);
        Node* toNode = graph->findNodeByName(to);
        graph->set_relation(fromNode, toNode, weight);
    }
    catch(const char* error_message){

        std::cout << error_message << std::endl;
    }
}

QVector<QVector<QString>> AppCore::getNodes(){

    return graph->getNodes();
}
