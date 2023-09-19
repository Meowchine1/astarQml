#ifndef STRONGCONNECTION_H
#define STRONGCONNECTION_H
#include <memory>
#include <time.h>

#include "node.h"

#define N 20

using arr_ptr_type = std::unique_ptr<std::unique_ptr<Node>[]>;
using NodePtr = std::unique_ptr<Node>;

class StrongConnection
{
public:
    arr_ptr_type mass = std::make_unique<std::unique_ptr<Node>[]>(N*N);

    int getRowCount() { return N; }
    int getColCount() { return N; }
    void print();
    void reset();
    static StrongConnection* getInstance();
    Node* getNode(int row, int column);

    ~StrongConnection(){
        //TO DO mass = delete;
    }

private:
    static StrongConnection* instance;
    StrongConnection();
    void addRandomRelation();
};

#endif // STRONGCONNECTION_H
