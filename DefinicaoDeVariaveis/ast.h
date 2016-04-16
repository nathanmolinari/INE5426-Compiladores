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
        virtual ~Node() { }
        virtual void printTree() { }
//        virtual int computeTree(){return 0;}
};

class Primitivo : public Node { }

  class Integer : public Primitivo {
      public:
          int value;
          Integer(int value) : value(value) { }
          void printTree();
  };

  class Racional : public Primitivo {
      public:
          double value;
          Racional(double value) : value(value) { }
          void printTree();
  }

  class Caracter : public Primitivo {
      public:
          char value;
          Caracter(char value) : value(value) { }
          void printTree();
  }

  class Sentenca : public Primitivo {
      public:
          string value;
          Sentenca(string value) : value(value) { }
          void printTree();
  }

  class Booleano : public Primitivo {
      public:
          bool value;
          Booleano(bool value) : value(value) { }
          void printTree();
  }

class Complexo : public Node { }

  class Identificador : public Complexo {
      public:
          string identificador;
          Identificador(std::string identificador) :
              identificador(identificador) { }
          void printTree();
          int computeTree();
  };

class Operacao : public Node { }

class Soma : public Operacao {
    
}

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
