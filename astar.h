#ifndef ASTAR_H
#define ASTAR_H

#include <queue>

#include "astar.h"
#include "node.h"
#include "graph.h"

class Astar
{
public:
    Astar();
    QString run(Node* start, Node* goal, Graph& graph);

private:
    std::vector<Node*> queue;
    std::vector<Node*> visited;
    std::unordered_map<Node*, Node*> parent;
    std::unordered_map<Node*, int> minWay;

    QString restorePath(Node* start, Node* goal);\
};

#endif // ASTAR_H
