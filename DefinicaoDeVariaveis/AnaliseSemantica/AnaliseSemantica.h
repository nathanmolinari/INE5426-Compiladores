#pragma once

#include <iostream>
#include <vector>
#include <map> //usar

using namespace std;

namespace AnaliseSemantica {

    template <typename T>
    class Nodo {
        public:
            virtual ~Nodo() { }
            virtual void print() { }
            virtual T executar() { }
    };

    template <typename T>
    class Bloco : public Nodo<T> {
        public:
            Bloco() { }
            std::vector<Nodo*> listaDeInstrucoes;
            void print();
            int executar();
    };
}
