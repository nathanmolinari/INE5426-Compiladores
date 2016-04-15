#include "ast.h"

using namespace AST;

/* Print methods */
void Integer::printTree(){
    cout << value;
    return;
}

void Identificador::printTree(){
    cout << identificador;
    return;
}

void BinOp::printTree(){
    left->printTree();
    switch(op){
        case plus:          cout << " + "; break;
        case mult:          cout << " * "; break;
    }
    right->printTree();
    return;
}

void Block::printTree(){
    for (Node* linha: linhas) {
        linha->printTree();
        cout << endl;
    }
}

/* Compute methods */
int Integer::computeTree(){
    return value;
}

int Identificador::computeTree(){
    return tabelaDeVariaveis[identificador];
}

int BinOp::computeTree(){
    int value, lvalue, rvalue;
    lvalue = left->computeTree();
    rvalue = right->computeTree();
    switch(op){
         case plus:         value = lvalue + rvalue; break;
         case mult:         value = lvalue * rvalue; break;
    }
    return value;
}

int Block::computeTree(){
    int value;
    for (Node* linha: linhas) {
        value = linha->computeTree();
         cout << "Computed " << value << endl;
    }
    return 0;
}
