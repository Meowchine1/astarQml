#include <algorithm>
#include <limits.h>
#include <iostream>
#include <string>
#include <QString>
#include <QVariant>
#include <bits/stdc++.h>

#include "astar.h"
#include "node.h"
#include "graph.h"
#include "heuristic.h"
#include "NodeException.h"

Astar::Astar(){}

std::vector<Node *> Astar::getVisited(){ return visited;}

void fillMax(std::unordered_map<Node*, int>& minWay, Graph* graph){
    for (auto& pair : graph->get_edges_weights())
    {
        minWay[pair.first] = INT_MAX;
    }
}

void fillMax(std::unordered_map<Node*, int>& minWay, StrongConnection* graph){
    for (int i = 0, j = 0; i < N; i++, j++) {
        minWay[graph->getNode(i, j)] = INT_MAX;
    }
}

QString Astar::restorePath(Node* start, Node* goal){
    QString path;
    Node* ptrNode = goal;
    Node* ptrtemp{nullptr};
    while (ptrNode != start)
    {
        path = ptrNode->name + " -> " + path;
        ptrtemp = parent[ptrNode];
        ptrNode = ptrtemp;
    }
    parent.clear();
    path = start->name + " -> " + path;
    return path.remove(path.size() - 3, path.size());
}

QVariantList Astar::restorePathWithCoordinates(Node* start, Node* goal){
    QVariantList path;
    Node* ptrNode = goal;
    Node* ptrtemp{nullptr};
    while (ptrNode != start)
    {
        path.append(QVariant(ptrNode->getX())); path.append(QVariant(ptrNode->getY()));
        ptrtemp = parent[ptrNode];
        ptrNode = ptrtemp;
    }
    parent.clear();
    path.append(QVariant(start->getX())); path.append(QVariant(start->getY()));
    return path;
}

QVariantList Astar::run(Node *start, Node *goal, StrongConnection *graph)
{
    queue.clear();
    minWay.clear();
    visited.clear();
    minWay.clear();

    queue.push_back(start);
    fillMax(minWay, graph);
    minWay[start] = 0;
    Node* currentptr = {nullptr};
    while(!queue.empty())
    {
        currentptr = queue.front(); queue.erase(queue.begin());
        if(currentptr == goal)
        {
            return restorePathWithCoordinates(start, goal);
        }
        visited.push_back(currentptr);

        for(Node* child : currentptr->children)
        {
            int pathWeight = 1;
            unsigned int heuristic = heuristic_Manhattan(child, goal);
            int newWeight = minWay[currentptr] + heuristic;
            if(std::find(visited.begin(),visited.end(), child) == visited.end()
                    || newWeight  < minWay[child])
            {
                parent[child] = currentptr;
                minWay[child] = newWeight;

                child->setDistance(heuristic);

                auto it = std::find(queue.begin(), queue.end(), child);
                if (it != queue.end()) { // нужно перестроить вектор тк существующий в векторе узел изменился

                    std::make_heap(queue.begin(), queue.end());
                }
                else{
                    queue.push_back(child);

                    std::sort(queue.begin(), queue.end(), NodeComparator());
                }
            }
        }
    }
    queue.clear();
    minWay.clear();
    visited.clear();
    minWay.clear();
    parent.clear();
    throw NodeException("No path");
}


