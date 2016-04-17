#pragma once

#include <iostream>
#include <vector>
#include <map>

using namespace std;

namespace AnaliseSemantica {

enum Operation { plus, mult };

class Node;

class Node {
    public:
        virtual ~Node() { }
        virtual void printTree() { }
//        virtual int computeTree(){return 0;}
};

class Block : public Node {
    public:
        Block() { }
        std::vector<Node*> listaDeInstrucoes;
        void printTree();
        int computeTree();
};

}
