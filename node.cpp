#include "node.h"

Node::Node(const QString _name): name{_name}
{}

Node::Node(const QString _name, const int _x, const int _y):
    name{_name}, x{_x}, y{_y}
{}
Node::~Node(){}


