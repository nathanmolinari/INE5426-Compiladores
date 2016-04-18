#include "AnaliseSemantica.h"

#include <iostream>

using namespace std;

namespace AnaliseSemantica {

    template <typename L, typename R>
    class Operacao : public Nodo<L> {
        protected:
            Nodo<L> *left;
            string *simbolo;
            Nodo<R> *right;
            Operacao(Nodo<L> *left, string *simbolo, Nodo<R> *right) : left(left), simbolo(simbolo), right(right) { }
        public:
            void print(){
                left->print();
                cout << *simbolo;
                right->print();
            };
    };

    template <typename L, typename R>
    class Soma : public Operacao<L, R> {
        protected:
            Soma(Nodo<L> *left, Nodo<R> *right) : Operacao<L, R>(left, new string("+"), right) { }
    };

    class Soma_int_int : public Soma<int, int> {
        public:
            Soma_int_int(Nodo<int> *left, Nodo<int> *right) : Soma(left, right) { }
            int executar();
    };

    class Soma_double_int : public Soma<double, int> {
        public:
            Soma_double_int(Nodo<double> *left, Nodo<int> *right) : Soma(left, right) { }
            double executar();
    };

    class Soma_double_double : public Soma<double, double> {
        public:
            Soma_int_int(Nodo<double> *left, Nodo<double> *right) : Soma(left, right) { }
            double executar();
    };


}
