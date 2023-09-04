#include <iostream>
#include <time.h>

#include "strongconnection.h"

StrongConnection* StrongConnection::instance = nullptr;

StrongConnection* StrongConnection::getInstance(){
   if(instance == nullptr){
       instance = new StrongConnection();
   }
   return instance;
}

 std::unique_ptr<Node> StrongConnection::getNode(int row, int column){

   std::unique_ptr<Node> node = std::move(mass[row * N + column]);
   return node;
}

void StrongConnection::addRandomRelation(){
   NodePtr node_0_0 = std::move(mass[0][0]);
   if(!node_0_0->isolated){
       NodePtr rightChild = std::move(mass[0][1]);
       NodePtr bottomChild = std::move(mass[1][0]);
       if(!rightChild->isolated){
           node_0_0->children.push_back(rightChild);
       }
       if(!bottomChild->isolated){
           node_0_0->children.push_back(bottomChild);
       }
   }
   NodePtr node_0_n = mass[0][N-1];
   if(!node_0_n->isolated){
       NodePtr leftChild = mass[0][N-2];
       NodePtr bottomChild = mass[1][N-1];
       if(!leftChild->isolated){
           node_0_n->children.push_back(leftChild);
       }
       if(!bottomChild->isolated){
           node_0_n->children.push_back(bottomChild);
       }
   }
   NodePtr node_n_0 = mass[N-1][0];
   if(!node_n_0->isolated){
       NodePtr rightChild = mass[N-1][1];
       NodePtr topChild = mass[N-2][0];
       if(!rightChild->isolated){
           node_n_0->children.push_back(rightChild);
       }
       if(!topChild->isolated){
           node_n_0->children.push_back(topChild);
       }
   }
   NodePtr node_n_n = mass[N-1][N-1];
   if(!node_n_n->isolated){
       NodePtr leftChild = mass[N-1][N-2];
       NodePtr topChild = mass[N-2][N-1];
       if(!leftChild->isolated){
           node_n_n->children.push_back(leftChild);
       }
       if(!topChild->isolated){
           node_n_n->children.push_back(topChild);
       }
   }


   for(int i = 1; i < N-1; i++){  // middle
       for(int j = 1; j < N-1; j++){
           NodePtr node = mass[i][j];
           NodePtr node1 = mass[i-1][j];
           NodePtr node2 = mass[i][j+1];
           NodePtr node3 = mass[i+1][j];
           NodePtr node4 = mass[i][j-1];
           if(!node->isolated){
               if(!node1->isolated){
                   node->children.push_back(node1);
               }
               if(!node2->isolated){
                   node->children.push_back(node2);
               }
               if(!node3->isolated){
                   node->children.push_back(node3);
               }
               if(!node4->isolated){
                   node->children.push_back(node4);
               }
           }
       }
   }
   for (int i = 0; i < 1; i++){  // top line
       for(int j = 1; j < N-1; j++){
           NodePtr node = mass[i][j];
           NodePtr node1 = mass[i][j-1];
           NodePtr node2 = mass[i][j+1];
           NodePtr node3 = mass[i+1][j];
           if(!node->isolated){
               if(!node1->isolated){
                   node->children.push_back(node1);
               }
               if(!node2->isolated){
                   node->children.push_back(node2);
               }
               if(!node3->isolated){
                   node->children.push_back(node3);
               }
           }
       }
   }
   for (int i = 1; i < N-1; i++){  //  left line
       for(int j = 0; j < 1; j++){
           NodePtr node = mass[i][j];
           NodePtr node1 = mass[i-1][j];
           NodePtr node2 = mass[i][j+1];
           NodePtr node3 = mass[i+1][j];
           if(!node->isolated){
               if(!node1->isolated){
                   node->children.push_back(node1);
               }
               if(!node2->isolated){
                   node->children.push_back(node2);
               }
               if(!node3->isolated){
                   node->children.push_back(node3);
               }
           }
       }
   }
   for (int i = N-1; i < N; i++){  //  bottom line
       for(int j = 1; j < N-1; j++){
           NodePtr node = mass[i][j];
           NodePtr node1 = mass[i-1][j];
           NodePtr node2 = mass[i][j+1];
           NodePtr node3 = mass[i][j-1];
           if(!node->isolated){
               if(!node1->isolated){
                   node->children.push_back(node1);
               }
               if(!node2->isolated){
                   node->children.push_back(node2);
               }
               if(!node3->isolated){
                   node->children.push_back(node3);
               }
           }
       }
   }
   for (int i = 1; i < N-1; i++){  //  right line
       for(int j = N-1; j < N; j++){
           NodePtr node = mass[i][j];
           NodePtr node1 = mass[i][j-1];
           NodePtr node2 = mass[i-1][j];
           NodePtr node3 = mass[i+1][j];
           if(!node->isolated){
               if(!node1->isolated){
                   node->children.push_back(node1);
               }
               if(!node2->isolated){
                   node->children.push_back(node2);
               }
               if(!node3->isolated){
                   node->children.push_back(node3);
               }
           }
       }
   }
}

