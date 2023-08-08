#ifndef GRAPH_H
#define GRAPH_H
#include <unordered_map>
#include "node.h"
#include <QString>
#include <QObject>
typedef std::unordered_map<Node*, std::unordered_map<Node*, int>> specified_map;
typedef std::unordered_map<Node*, int> inner_map;

class Graph : public QObject
{

    Q_OBJECT

private:
    specified_map edges_weights;

public:
    std::vector<Node*> nodes;
    Graph(QString filePath);
    Graph();
    specified_map get_edges_weights(){return edges_weights;}
    inner_map get_edges_weights(Node* keyNode)
    {
        return edges_weights[keyNode];
    }

    Node* findNodeByName(QString name);
    void readtxt(QString filePath);
    void addNode(Node* node);
    void set_relation(Node* from, Node* to, int weight);
    int get_edge_weight(const Node* keyNode, const Node* childNode);
    void printGraph();
    ~Graph();


};

#endif // GRAPH_H
