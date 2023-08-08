#include "node.h"

Node::Node(const QString _name): name{_name}
{}

Node::Node(const QString _name, int _x, int _y):
    name{_name}, x{_x}, y{_y}
{}
Node::~Node(){}


