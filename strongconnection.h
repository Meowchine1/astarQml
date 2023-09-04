#ifndef STRONGCONNECTION_H
#define STRONGCONNECTION_H
#include <memory>
#include <time.h>

#include "node.h"

#define N 20

using arr_ptr_type = std::unique_ptr<Node[]>;
using NodePtr = std::unique_ptr<Node>;

class StrongConnection
{
public:
    std::unique_ptr<std::unique_ptr<Node>[]> mass = std::unique_ptr<Node[]>(new Node[N*N]);

    StrongConnection(){
        srand(time(NULL));
        for (int i = 0, main_i = 0; i < N; i++, main_i++){
            for (int j = 0 ; j< N; j++){
                float p = (float)rand() / (float)RAND_MAX;
                mass[main_i] = std::make_unique<Node>(i, j, (p > 0.7));
            }
        }
        addRandomRelation();
    }

    int getRowCount() { return N; }
    int getColCount() { return N; }
    void print();
    static StrongConnection* getInstance();
    std::unique_ptr<Node> getNode(int row, int column);

    ~StrongConnection(){
        //mass = delete;
    }

private:
    static StrongConnection* instance;
    StrongConnection(){}
    void addRandomRelation();
};

#endif // STRONGCONNECTION_H
