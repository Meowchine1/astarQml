#include <algorithm>
#include <limits.h>
#include <iostream>
#include <string>
#include <QString>

#include "astar.h"
#include "node.h"
#include "graph.h"
#include "heuristic.h"

Astar::Astar(){}

void fillMax(std::unordered_map<Node*, int>& minWay, Graph& graph)
{
    for (auto& pair : graph.get_edges_weights())
    {
        minWay[pair.first] = INT_MAX;
    }
}

QString Astar::restorePath(Node* start, Node* goal)
{
    QString path;
    Node* ptrNode = goal;
    Node* ptrtemp{nullptr};
    while (ptrNode != start)
    {
        path = ptrNode->name + " -> " + path;
        ptrtemp = parent[ptrNode];
        ptrNode = ptrtemp;
    }
    path = start->name + " -> " + path;
    return path;
}

QString Astar::run(Node* start, Node* goal, Graph& graph)
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
           return restorePath(start, goal);
       }

       visited.push_back(currentptr);
       auto it = graph.get_edges_weights().find(const_cast<Node*>(currentptr));
       if(it != graph.get_edges_weights().end())
       {
            for(auto& pair : graph.get_edges_weights(currentptr))
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

    return "no path";
}
