#include "AnaliseSemantica.h"

using namespace AnaliseSemantica;

void Bloco::print(){
    for (TipoFundamental instrucao: listaDeInstrucoes) {
        switch(instrucao.which()){
            case 0:   boost::get<Nodo<int>*>(instrucao)->print(); break;
            case 1:   boost::get<Nodo<double>*>(instrucao)->print(); break;
            case 2:   boost::get<Nodo<bool>*>(instrucao)->print(); break;
            case 3:   boost::get<Nodo<char>*>(instrucao)->print(); break;
            case 4:   boost::get<Nodo<string>*>(instrucao)->print(); break;
            case 5:   boost::get<Nodo<void>*>(instrucao)->print(); break;
        }
        cout << endl;
    }
}

void Bloco::executar(){
  switch(instrucao.which()){
      case 0:   boost::get<Nodo<int>*>(instrucao)->executar(); break;
      case 1:   boost::get<Nodo<double>*>(instrucao)->executar(); break;
      case 2:   boost::get<Nodo<bool>*>(instrucao)->executar(); break;
      case 3:   boost::get<Nodo<char>*>(instrucao)->executar(); break;
      case 4:   boost::get<Nodo<string>*>(instrucao)->executar(); break;
      case 5:   boost::get<Nodo<void>*>(instrucao)->executar(); break;
  }
}
