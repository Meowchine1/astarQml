#include <iostream>
#include <time.h>
#include "strongconnection.h"


StrongConnection* StrongConnection::instance = nullptr;
void StrongConnection::print(){
   for (int i = 0; i< N; i++){
       for(int j = 0; j < N; j++){
           Node* node = mass[i][j];
           std::cout<< node->isolated << " coord(" << i << ";" << j <<") " << " childrens:";

           for(Node* child: node->children){
               std::cout<< child->getX() << ";" << child->getY()<< "\t";
           }
           std::cout<<std::endl;
       }
       std::cout<<std::endl;
   }

   for (int i = 0; i< N; i++){
       for(int j = 0; j < N; j++){
           Node* node = mass[i][j];
           std::cout<< node->isolated << " ";

       }
       std::cout<<std::endl;
   }
}

void StrongConnection::createRandomNew(){
   srand(time(NULL));
   for (int i = 0; i< N; i++){
       for(int j = 0; j < N; j++){
           float p = (float)rand() / (float)RAND_MAX;
           mass[i][j] = new Node(i, j, (p > 0.7));
       }
   }
   addRandomRelation();
}

StrongConnection* StrongConnection::getInstance(){
   if(instance == nullptr){
       instance = new StrongConnection();
   }
   return instance;
}

Node* StrongConnection::getNode(int row, int column){
   return mass[row][column];
}

void StrongConnection::addRandomRelation(){
   Node* node_0_0 = mass[0][0];
   if(!node_0_0->isolated){
       Node* rightChild = mass[0][1];
       Node* bottomChild = mass[1][0];
       if(!rightChild->isolated){
           node_0_0->children.push_back(rightChild);
       }
       if(!bottomChild->isolated){
           node_0_0->children.push_back(bottomChild);
       }
   }
   Node* node_0_n = mass[0][N-1];
   if(!node_0_n->isolated){
       Node* leftChild = mass[0][N-2];
       Node* bottomChild = mass[1][N-1];
       if(!leftChild->isolated){
           node_0_n->children.push_back(leftChild);
       }
       if(!bottomChild->isolated){
           node_0_n->children.push_back(bottomChild);
       }
   }
   Node* node_n_0 = mass[N-1][0];
   if(!node_n_0->isolated){
       Node* rightChild = mass[N-1][1];
       Node* topChild = mass[N-2][0];
       if(!rightChild->isolated){
           node_n_0->children.push_back(rightChild);
       }
       if(!topChild->isolated){
           node_n_0->children.push_back(topChild);
       }
   }
   Node* node_n_n = mass[N-1][N-1];
   if(!node_n_n->isolated){
       Node* leftChild = mass[N-1][N-2];
       Node* topChild = mass[N-2][N-1];
       if(!leftChild->isolated){
           node_n_n->children.push_back(leftChild);
       }
       if(!topChild->isolated){
           node_n_n->children.push_back(topChild);
       }
   }


   for(int i = 1; i < N-1; i++){  // middle
       for(int j = 1; j < N-1; j++){
           Node* node = mass[i][j];
           Node* node1 = mass[i-1][j];
           Node* node2 = mass[i][j+1];
           Node* node3 = mass[i+1][j];
           Node* node4 = mass[i][j-1];
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
           Node* node = mass[i][j];
           Node* node1 = mass[i][j-1];
           Node* node2 = mass[i][j+1];
           Node* node3 = mass[i+1][j];
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
           Node* node = mass[i][j];
           Node* node1 = mass[i-1][j];
           Node* node2 = mass[i][j+1];
           Node* node3 = mass[i+1][j];
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
           Node* node = mass[i][j];
           Node* node1 = mass[i-1][j];
           Node* node2 = mass[i][j+1];
           Node* node3 = mass[i][j-1];
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
           Node* node = mass[i][j];
           Node* node1 = mass[i][j-1];
           Node* node2 = mass[i-1][j];
           Node* node3 = mass[i+1][j];
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

