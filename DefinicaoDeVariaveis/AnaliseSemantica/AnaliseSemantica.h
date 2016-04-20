#pragma once

#include <iostream>
#include <vector>
#include <boost/variant.hpp>

using namespace boost;
using namespace std;

namespace AnaliseSemantica {

    typedef variant<
        Nodo<int>*, Nodo<double>*,
        Nodo<bool>*,
        Nodo<char>* Nodo<string>*
        Nodo<void>*
    > TipoFundamental;

    template <typename T>
    class Nodo {
        public:
            virtual ~Nodo() { }
            virtual void print() { }
            virtual T executar() { }
    };

    class Bloco : public Nodo<void> {
        public:
            vector<TipoFundamental> listaDeInstrucoes;

            Bloco() { }
            void print();
            void executar();
    };
}
