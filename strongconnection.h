#ifndef STRONGCONNECTION_H
#define STRONGCONNECTION_H
#include <memory>

#include "node.h"

#define N 20

class StrongConnection
{
public:
   std::unique_ptr<Node> mass [N][N];

   void print();

   void createRandomNew();

   static StrongConnection* getInstance();

   Node* getNode(int row, int column);

   ~StrongConnection(){
       //mass = delete;
   }

private:
   static StrongConnection* instance;
   StrongConnection(){}
   void addRandomRelation();
};

#endif // STRONGCONNECTION_H
