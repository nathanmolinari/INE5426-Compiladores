#pragma once

#ifndef __ANALISESEMANTICA_H_INCLUDED__
#define __ANALISESEMANTICA_H_INCLUDED__

#include <iostream>
#include <vector>
#include <map> //usar

using namespace std;

namespace AnaliseSemantica {

    enum Operation { plus, mult };

    template <typename T>
    class Nodo {
        public:
            virtual ~Nodo() { }
            virtual void printTree() { }
            virtual T computeTree() { }
    };

    template <typename T>
    class Bloco : public Nodo<T> {
        public:
            Bloco() { }
            std::vector<Nodo*> listaDeInstrucoes;
            void printTree();
            int computeTree();
    };
}

#endif
