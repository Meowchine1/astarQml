#ifndef GRAPH_H
#define GRAPH_H
#include <unordered_map>
#include "node.h"
#include <QObject>
typedef std::unordered_map<Node*, std::unordered_map<Node*, int>> specified_map;
typedef std::unordered_map<Node*, int> inner_map;

class Graph : public QObject
{
    Q_OBJECT
private:
    static Graph* instance;
    Graph(){}

    specified_map edges_weights;

public:
    std::vector<Node*> nodes;

    static Graph* getInstance();

    Graph(Graph& other) = delete;
    void operator=(Graph& other) = delete;


    Node* findNodeByName(QString name);
    int get_edge_weight(const Node* keyNode, const Node* childNode);

    QVector<QVector<QString>> getNodes();
    specified_map get_edges_weights(){ return edges_weights; }
    inner_map get_edges_weights(Node* keyNode){ return edges_weights[keyNode]; }

    void readtxt(QString filePath);
    void addNode(Node* node);
    void addNode(QString name, QString x, QString y);
    void set_relation(Node* from, Node* to, int weight);

    void printGraph();
    ~Graph();


};



#endif // GRAPH_H
