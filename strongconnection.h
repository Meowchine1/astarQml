#ifndef STRONGCONNECTION_H
#define STRONGCONNECTION_H
#include "node.h"

#define N 20

class StrongConnection
{
public:
   Node* mass [N][N];

   void print();

   void createRandomNew();

   static StrongConnection* getInstance();

   Node* getNode(int row, int column);

private:
   static StrongConnection* instance;
   StrongConnection(){}
   void addRandomRelation();
};

#endif // STRONGCONNECTION_H
