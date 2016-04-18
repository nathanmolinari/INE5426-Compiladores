#include "AnaliseSemantica.h"

using namespace AnaliseSemantica;

void Bloco::print(){
    for (Nodo* instrucao: listaDeInstrucoes) {
        instrucao->print();
        cout << endl;
    }
}

int Bloco::executar(){
    for (Nodo* instrucao: listaDeInstrucoes) {
        instrucao->executar();
    }
    return 0;
}
