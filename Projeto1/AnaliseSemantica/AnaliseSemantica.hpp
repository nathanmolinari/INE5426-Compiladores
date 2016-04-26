#pragma once

#include <iostream>
#include <vector>

#include "boost/variant.hpp"
#include "boost/variant/apply_visitor.hpp"
#include "boost/variant/static_visitor.hpp"

using namespace boost;
using namespace std;

namespace AnaliseSemantica {

    typedef variant<
        Nodo<int>*, Nodo<double>*,
        Nodo<bool>*,
        Nodo<char>*, Nodo<string>*,
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

            Bloco() : Nodo() { };
            void print(){
                for(int i=0; i < listaDeInstrucoes.size(); i++){
                    apply_visitor(PrintFundamentalVisitor(), listaDeInstrucoes[i]);
                }
            }
            void executar(){
                for(int i=0; i < listaDeInstrucoes.size(); i++){
                    apply_visitor(ExecutarFundamentalVisitor(), listaDeInstrucoes[i]);
                }
            }

        class PrintFundamentalVisitor : public static_visitor<void>{
            public:
                void operator()(Nodo<int>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
                void operator()(Nodo<double>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
                void operator()(Nodo<bool>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
                void operator()(Nodo<char>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
                void operator()(Nodo<string>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
                void operator()(Nodo<void>*& nodo) const {
                    nodo->print();
                    cout << endl;
                }
        };

        class ExecutarFundamentalVisitor : public static_visitor<void>{
            public:
                void operator()(Nodo<int>*& nodo) const {
                    nodo->executar();
                }
                void operator()(Nodo<double>*& nodo) const {
                    nodo->executar();
                }
                void operator()(Nodo<bool>*& nodo) const {
                    nodo->executar();
                }
                void operator()(Nodo<char>*& nodo) const {
                    nodo->executar();
                }
                void operator()(Nodo<string>*& nodo) const {
                    nodo->executar();
                }
                void operator()(Nodo<void>*& nodo) const {
                    nodo->executar();
                }
        };
    };
}
