#ifndef HEURISTIC_H
#define HEURISTIC_H

#include "node.h"

#include <cmath>

int heuristic_Manhattan(Node *v1, Node *v2)
{
    return abs(v1->getX() - v2->getX()) + abs(v1->getY() - v2->getY());
}

int heuristic_Chebyshev(Node *v1, Node *v2)
{
    return std::max(abs(v1->getX() - v2->getX()), abs(v1->getY() - v2->getY()));
}

int heuristic_Euclid(Node *v1, Node *v2)
{
    return sqrt(pow((v1->getX() - v2->getX()), 2) + pow((v1->getY() - v2->getY()), 2));
}


#endif // HEURISTIC_H
