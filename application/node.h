#ifndef NODE_H
#define NODE_H
#include <QString>
#include <QObject>
#include <memory>

#define UNDEFINED 1435483

class Node{

private:
    int x = UNDEFINED, y = UNDEFINED;
    unsigned int distance = 0;

public:
    // for random graph generation
    bool isolated;
    std::vector<Node*> children;
    Node(int _x, int _y, bool _isolated): x(_x), y(_y), isolated(_isolated) {}
    //
    const QString name; // unique
    Node(const QString _name);
    Node(const QString _name, int _x, int _y);
    Node(){}
    ~Node(){
        if (children.capacity()>0){
            for (auto child : children) {
                delete child;
            }
        }
    }

    Node(const Node&) = delete;
    Node& operator=(const Node&) = delete;

//    bool operator()(const Node* a, const Node* b) const {
//        return a->distance< b->distance;
//    }

    int getX() const {return x;}
    int getY() const {return y;}
    int getDistance() const {return distance;}
    void setX(const int value){
        if(x == UNDEFINED){
            x = value;
        }else{
            throw "coordinate 'x' was initialized";
        }
    }
    void  setY(const int value)
    {
        if(y == UNDEFINED){
            y = value;
        }else{
            throw "coordinate 'y' was initialized";
        }
    }
    void setDistance(unsigned int value){
        distance = value;
    }
};

struct NodeComparator
{
    bool operator ()(const Node* a, const Node* b)
    {
        return a->getDistance() < b->getDistance();
    }
};

struct NodeDeleter {
    void operator()(Node* ptr) {
        delete[] ptr;
    }
};

#endif // NODE_H
