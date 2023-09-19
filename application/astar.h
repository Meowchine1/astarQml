#ifndef ASTAR_H
#define ASTAR_H

#include <queue>

#include "node.h"
#include "graph.h"
#include "strongconnection.h"

class Astar{
public:
    Astar();
    QString run(Node* start, Node* goal, Graph* graph);
    QVariantList run(Node* start, Node* goal, StrongConnection* graph);
    QVariantList restorePathWithCoordinates(Node *start, Node *goal);
private:
    std::vector<Node*> queue;
    std::vector<Node*> visited;
    std::unordered_map<Node*, Node*> parent;
    std::unordered_map<Node*, int> minWay;

    QString restorePath(Node* start, Node* goal);\
};

#endif // ASTAR_H
