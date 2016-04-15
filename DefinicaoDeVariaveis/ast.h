#pragma once

#include <iostream>
#include <vector>
#include <map>

using namespace std;

namespace AST {

//Binary operations
enum Operation { plus, mult };

class Node;
extern map<string, int> tabelaDeVariaveis;

typedef std::vector<Node*> NodeList; //List of ASTs

class Node {
    public:
        virtual ~Node() {}
        virtual void printTree(){}
        virtual int computeTree(){return 0;}
};

class Integer : public Node {
    public:
        int value;
        Integer(int value) : value(value) {  }
        void printTree();
        int computeTree();
};

class Identificador : public Node {
    public:
        string identificador;
        Identificador(std::string identificador) :
            identificador(identificador) { }
        void printTree();
        int computeTree();
};

class BinOp : public Node {
    public:
        Operation op;
        Node *left;
        Node *right;
        BinOp(Node *left, Operation op, Node *right) :
            left(left), right(right), op(op) { }
        void printTree();
        int computeTree();
};

class Block : public Node {
    public:
        Block() { }
        NodeList linhas;
        void printTree();
        int computeTree();
};

}
