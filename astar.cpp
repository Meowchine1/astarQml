#include <algorithm>
#include <limits.h>
#include <iostream>
#include <string>
#include <QString>
#include <QVariant>

#include "astar.h"
#include "node.h"
#include "graph.h"
#include "heuristic.h"
#include "NodeException.h"

Astar::Astar(){}

void fillMax(std::unordered_map<Node*, int>& minWay, Graph* graph){
    for (auto& pair : graph->get_edges_weights())
    {
        minWay[pair.first] = INT_MAX;
    }
}

void fillMax(std::unordered_map<Node*, int>& minWay, StrongConnection* graph){

    for (int i = 0, j = 0; i < N; i++, j++) {
        minWay[graph->mass[i][j]] = INT_MAX;
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

QString Astar::run(Node* start, Node* goal, Graph* graph){
    queue.push_back(start);
    fillMax(minWay, graph);
    minWay[start] = 0;
    Node* currentptr = {nullptr};
    while(!queue.empty())
    {
        currentptr = queue.front(); queue.erase(queue.begin());
        if(currentptr == goal)
        {
            queue.clear();
            minWay.clear();
            visited.clear();
            minWay.clear();
            return restorePath(start, goal);
        }
        visited.push_back(currentptr);
        auto it = graph->get_edges_weights().find(const_cast<Node*>(currentptr));
        if(it != graph->get_edges_weights().end())
        {
            for(auto& pair : graph->get_edges_weights(currentptr))
            {
                Node* child = pair.first;
                int pathWeight = pair.second;

                if(std::find(visited.begin(),
                             visited.end(), child) == visited.end()
                        || minWay[currentptr] + pathWeight < minWay[child])
                {
                    parent[child] = currentptr;
                    minWay[child] = minWay[currentptr] + pathWeight;
                    unsigned int heuristic =
                            heuristic_Manhattan(child, goal);
                    child->setDistance(heuristic + pathWeight);

                    auto it = std::find(queue.begin(), queue.end(), child);
                    if (it != queue.end()) { // нужно перестроить вектор тк существующий в векторе узел изменился

                        std::make_heap(queue.begin(), queue.end());
                    }
                    else{
                        queue.push_back(child);
                        std::sort(queue.begin(), queue.end());
                    }
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

QVariantList Astar::run(Node *start, Node *goal, StrongConnection *graph)
{
    queue.push_back(start);
    fillMax(minWay, graph);
    minWay[start] = 0;
    Node* currentptr = {nullptr};
    while(!queue.empty())
    {
        currentptr = queue.front(); queue.erase(queue.begin());
        if(currentptr == goal)
        {
            queue.clear();
            minWay.clear();
            visited.clear();
            minWay.clear();
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
                    std::sort(queue.begin(), queue.end());
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
