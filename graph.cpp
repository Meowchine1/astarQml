#include <iostream>
#include <fstream>
#include<algorithm>
#include <bits/stdc++.h>

#include "splitter.h"
#include "graph.h"
#include "NodeException.h"

Graph* Graph::instance = nullptr;

void Graph::addNode(Node* node){
    auto it = std::find_if(nodes.begin(),
                           nodes.end(), [&](const Node* elem) {
        return elem->name == node->name;
    });
    if(it == nodes.end())
    {
        edges_weights[node] = std::unordered_map<Node*, int>();
        nodes.push_back(node);
    }
    else{
        throw NodeException("Node already exist.");
    }
}

void Graph::deleteNode(QString name){
    Node* deleteNode = findNodeByName(name);
    auto nodesIt = std::find_if(nodes.begin(),
                                nodes.end(), [&](const Node* elem){
        return elem == deleteNode;
    });
    auto edgesIt = edges_weights.find(const_cast<Node*>(deleteNode));
    if(nodesIt != nodes.end() && edgesIt != edges_weights.end()){
        nodes.erase(nodesIt);
        edges_weights.erase(edgesIt);
    }
    for(auto row: edges_weights){
        auto childIt = row.second.find(const_cast<Node*>(deleteNode));
        row.second.erase(childIt);
    }
    deleteNode->~Node();
}

int Graph::get_edge_weight(const Node* keyNode, const Node* childNode){
    auto it = edges_weights.find(const_cast<Node*>(keyNode));
    if (it != edges_weights.end()) {
        const std::unordered_map<Node*, int>& innerMap = it->second;
        auto innerIt = innerMap.find(const_cast<Node*>(childNode));
        if (innerIt != innerMap.end())
        {
            return innerIt->second;
        }else{
            throw NodeException("Realtions between " + keyNode->name + " and " + childNode->name
                                + " aren't exist.");
        }
    }else{
        throw NodeException("Node" + keyNode->name + " unexists.");
    }
}

QVector<QVector<QString>> Graph::getNodes(){
    QVector<QVector<QString>> result;
    for(Node* node: nodes){
        result.append({node->name, QString::number(node->getX()), QString::number(node->getY())});
    }
    return result;
}

QVector<QString> Graph::getNodesNames(){
    QVector<QString> result;
    for(Node* node: nodes){
        result.append(node->name);
    }
    return result;
}

void Graph::deleteRelation(QString from, QString to){
    try{
        Node* fromNode = findNodeByName(from);
        Node* toNode = findNodeByName(to);
        auto itFrom = std::find_if(edges_weights.begin(),edges_weights.end(), [&](const auto& elem) {
            return elem.first == fromNode;
        });
        std::unordered_map<Node*, int>& innerMap = itFrom->second;
        auto childIt = std::find_if(innerMap.begin(), innerMap.end(), [&](const auto& elem){
          return elem.first == toNode;
        });
        if(childIt != innerMap.end()){
            innerMap.erase(childIt);
        }
        else{
            throw (NodeException("Relation unexist"));
        }
    }
    catch(NodeException ex){
        throw (NodeException("Uncorrect nodes"));
    } //TO DO

}

Node* Graph::findNodeByName(QString name){
    auto it = std::find_if(nodes.begin(),
                           nodes.end(), [&](const Node* elem) {
        return elem->name == name;
    });
    if(it != nodes.end())
    {
        return *it;
    }else{
        throw NodeException("Node with name '" + name + "'  is't exist.");
    }
}

void Graph::set_relation(QString from, QString to, int weight){
    try{
        Node* fromNode = findNodeByName(from);
        Node* toNode = findNodeByName(to);
        auto itFrom = std::find_if(edges_weights.begin(),
                                   edges_weights.end(), [&](const auto& elem) {
            return elem.first == fromNode;
        });
        const std::unordered_map<Node*, int>& innerMap = itFrom->second;
        auto relationIt = innerMap.find(const_cast<Node*>(toNode));
        if(relationIt == innerMap.end()){
            edges_weights[fromNode][toNode] = weight;
        }
        else{
            throw (NodeException("Relation already exist"));
        }
    }
    catch(NodeException ex){ } //TO DO
}

Graph::~Graph(){
    for (auto& pair : edges_weights)
    {
        pair.second.clear();
    }
    edges_weights.clear();
}

Graph* Graph::getInstance(){
    if(instance == nullptr){
        instance = new Graph();
    }
    return instance;
}

void Graph::readtxt(QString filePath){
    edges_weights.clear();
    std::string line;
    char lineSeparator = '\n',
            innerSeparator = ' ',
            coordinateSeparator = '(';
    int i;
    size_t pos = 0;
    std::ifstream in(filePath.toStdString());
    std::cout<<std::endl;
    if (in.is_open())
    {
        while (std::getline(in, line, lineSeparator))
        {
            i = 0;
            QString nodename;
            int weight;
            int x, y;
            Node* ptrMainNode{nullptr};
            Node* ptrNeighborNode{nullptr};
            std::stringstream ss(line);
            std::string word;
            while (ss >> word) {    //extract word from the stream.
                if(i == 0){     //way for node with coordinates (first elem in line)
                    nodename = QString::fromStdString(getSubstring(word, pos, '('));
                    x = std::stoi(getSubstring(word, pos, ','));
                    y = std::stoi(getSubstring(word, pos, ')'));
                    auto it = std::find_if(nodes.begin(),
                                           nodes.end(), [&](const Node* elem) {
                        return elem->name == nodename;
                    });
                    if (it != nodes.end()) {    //if node has already initialized
                        ptrMainNode = *it;
                        ptrMainNode->setX(x);
                        ptrMainNode->setY(y);
                    }else{      // if uninitialized node
                        ptrMainNode = new Node(nodename, x, y);
                        edges_weights[ptrMainNode] =
                                std::unordered_map<Node*, int>();
                        nodes.push_back(ptrMainNode);
                    }
                }else{      // for neighbors
                    nodename =  QString::fromStdString(getSubstring(word, pos, '('));
                    weight = std::stoi(getSubstring(word, pos, ')'));
                    auto it = std::find_if(nodes.begin(),
                                           nodes.end(), [&](const Node* elem) {
                        return elem->name == nodename;
                    });
                    if (it != nodes.end()) {
                        ptrNeighborNode = *it;
                    }else{
                        ptrNeighborNode = new Node(nodename);
                        nodes.push_back(ptrNeighborNode);
                    }
                    edges_weights[ptrMainNode][ptrNeighborNode] = weight;
                }
                i++;
            }
            std::cout << std::endl;std::cout << std::endl;
        }
        std::cout << std::endl;
    }
    in.close();
    return;
}

void Graph::printGraph(){
    for (auto& pair : edges_weights) {
        const Node* keyNode = pair.first;
        std::unordered_map<Node*, int>& innerMap = pair.second;
        QString message = "Vertex is " + keyNode->name + " coordinates("
                + QString::number(keyNode->getX()) + ";" + QString::number(keyNode->getY()) + ")\t neighbors: ";
        std::cout<< message.toStdString();
        for (auto& innerPair : innerMap) {
            const Node* childNode = innerPair.first;
            int value = innerPair.second;
            message = "name:" + childNode->name + " coordinates(" + QString::number(childNode->getX()) + ";"
                    + QString::number(childNode->getY()) + ") " + " weight = " + QString::number(value) + "\n";
            std::cout<< message.toStdString();
        }
    }
}

QVector<QVector<QString> > Graph::getRelations(){
    QVector<QVector<QString> > result;
    for(auto& pair : edges_weights){
        const Node* keyNode = pair.first;
        inner_map innerMap = pair.second;
        for (auto& innerPair : innerMap) {
            const Node* childNode = innerPair.first;
            result.append({keyNode->name, childNode->name});
        }
    }
    return result;
}



