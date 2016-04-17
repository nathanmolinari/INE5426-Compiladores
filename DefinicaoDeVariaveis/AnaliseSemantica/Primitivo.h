#pragma once

#include "AnaliseSemantica.h"

#include <iostream>

using namespace std;

namespace AnaliseSemantica {

    template <typename T>
    class Primitivo : public Nodo<T> {
        protected:
            T valor;
            Primitivo(T valor) : valor(valor) { }
        public:
            void print(){
                cout << valor << endl;
            };
            T executar(){
                return valor;
            }
    };

    class Inteiro : public Primitivo<int> {
        public:
            Primitivo(int valor) : Primitivo(valor) { }
    };

    class Racional : public Primitivo<double> {
        public:
            Primitivo(double valor) : Primitivo(valor) { }
    };

    class Booleano : public Primitivo<bool> {
        public:
            Primitivo(bool valor) : Primitivo(valor) { }
    };

    class Caracter : public Primitivo<char> {
        public:
            Primitivo(char valor) : Primitivo(valor) { }
    };

    class Sentenca : public Primitivo<string> {
        public:
            Primitivo(string valor) : Primitivo(valor) { }
    };
}
