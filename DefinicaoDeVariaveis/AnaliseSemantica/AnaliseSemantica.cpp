#include "AnaliseSemantica.h"

using namespace AnaliseSemantica;

/* Print methods */
void Block::printTree(){
    for (Node* instrucao: listaDeInstrucoes) {
        instrucao->printTree();
        cout << endl;
    }
}

/* Compute methods */
int Block::computeTree(){
    int value;
    for (Node* instrucao: listaDeInstrucoes) {
        value = instrucao->computeTree();
         cout << "Computed " << value << endl;
    }
    return 0;
}
