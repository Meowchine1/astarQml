#ifndef GRAPH_H
#define GRAPH_H
#include <unordered_map>
#include <QObject>

#include "node.h"

typedef std::unordered_map<Node*, std::unordered_map<Node*, int>> specified_map;
typedef std::unordered_map<Node*, int> inner_map;

class Graph : public QObject
{
    Q_OBJECT

private:
    static Graph* instance;
    specified_map edges_weights;
    Graph(){}

public:
    std::vector<Node*> nodes;
    static Graph* getInstance();
    ~Graph();



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
    void deleteNode(QString name);

    void set_relation(QString from, QString to, int weight);
    void printGraph();

    QVector<QVector<QString> > getRelations();

    QVector<QString> getNodesNames();
    void deleteRelation(QString from, QString to);
};

#endif // GRAPH_H
