#include "AnaliseSemantica.h"

using namespace AnaliseSemantica;

/* Print methods */
void Block::printTree(){
    for (Nodo* instrucao: listaDeInstrucoes) {
        instrucao->printTree();
        cout << endl;
    }
}

/* Compute methods */
int Block::computeTree(){
    int value;
    for (Nodo* instrucao: listaDeInstrucoes) {
        value = instrucao->computeTree();
         cout << "Computed " << value << endl;
    }
    return 0;
}
