#include <iostream>
#include <time.h>
#include <memory>

#include "strongconnection.h"

StrongConnection* StrongConnection::instance = nullptr;

StrongConnection* StrongConnection::getInstance(){
    if(instance == nullptr){
        instance = new StrongConnection();
    }
    return instance;
}

bool isIsolated(){
    float p = ((float)rand() / (float)RAND_MAX);
    return  p >= 0.7;
}

void StrongConnection::reset(){
    for (int i = 0; i < N; i++){
        for (int j = 0 ; j< N; j++){
            Node* uniqueNode = mass[i*N+j].get();
            uniqueNode->children.clear();
            uniqueNode->isolated = isIsolated();
        }
    }
    addRandomRelation();
}

Node* StrongConnection::getNode(int row, int column){
   return mass[row * N + column].get();
}

StrongConnection::StrongConnection(){
    srand(time(NULL));
    for (int i = 0; i < N; i++){
        for (int j = 0 ; j< N; j++){
            std::unique_ptr<Node> uniqueNode = std::make_unique<Node>(i, j, isIsolated());
            mass[i*N+j] = std::move(uniqueNode);
        }
    }
    addRandomRelation();
}

void StrongConnection::addRandomRelation(){
    Node* node_0_0 = mass[0].get();
    if(!node_0_0->isolated){
        Node* rightChild = mass[1].get();
        Node* bottomChild = mass[N].get();
        if(!rightChild->isolated){
            node_0_0->children.push_back(rightChild);
        }
        if(!bottomChild->isolated){
            node_0_0->children.push_back(bottomChild);
        }
    }
    Node* node_0_n = mass[N-1].get();
    if(!node_0_n->isolated){
        Node* leftChild = mass[N-2].get();
        Node* bottomChild = mass[N + N-1].get();
        if(!leftChild->isolated){
            node_0_n->children.push_back(leftChild);
        }
        if(!bottomChild->isolated){
            node_0_n->children.push_back(bottomChild);
        }
    }
    Node* node_n_0 = mass[(N-1) * N].get();
    if(!node_n_0->isolated){
        Node* rightChild = mass[(N-1) * N + 1].get();
        Node* topChild = mass[(N-2) * N].get();
        if(!rightChild->isolated){
            node_n_0->children.push_back(rightChild);
        }
        if(!topChild->isolated){
            node_n_0->children.push_back(topChild);
        }
    }
    Node* node_n_n = mass[N * N - 1].get();
    if(!node_n_n->isolated){
        Node* leftChild = mass[N * N - 2].get();
        Node* topChild = mass[(N-1) * N - 1].get();
        if(!leftChild->isolated){
            node_n_n->children.push_back(leftChild);
        }
        if(!topChild->isolated){
            node_n_n->children.push_back(topChild);
        }
    }
    for(int i = 1; i <= N-2; i++){  // middle
        for(int j = 1; j <= N-2; j++){
            Node* node = mass[i * N + j].get();
            if(!node->isolated){
                Node* node1 = mass[(i-1) * N + j].get();
                Node* node2 = mass[i * N + j + 1].get();
                Node* node3 = mass[(i+1) * N + j].get();
                Node* node4 = mass[i * N + j - 1].get();
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
            Node* node = mass[i * N + j].get();
            if(!node->isolated){
                Node* node1 = mass[i * N + j-1].get();
                Node* node2 = mass[i * N + j+1].get();
                Node* node3 = mass[(i+1) * N + j].get();
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
            Node* node = mass[i * N + j].get();
            if(!node->isolated){
                Node* node1 = mass[(i-1) * N + j].get();
                Node* node2 = mass[i * N + j + 1].get();
                Node* node3 = mass[(i+1) * N + j].get();
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
            Node* node = mass[i * N + j].get();
            if(!node->isolated){
                Node* node1 = mass[(i-1) * N + j].get();
                Node* node2 = mass[i * N + j + 1].get();
                Node* node3 = mass[i* N + j - 1].get();
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
            Node* node = mass[i * N + j].get();
            if(!node->isolated){
                Node* node1 = mass[i * N + j-1].get();
                Node* node2 = mass[(i-1) * N + j].get();
                Node* node3 = mass[(i+1) * N + j].get();
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

