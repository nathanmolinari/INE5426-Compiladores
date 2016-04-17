#pragma once

#include <iostream>
#include <vector>
#include <map>

using namespace std;

namespace AnaliseSemantica {

  enum Operation { plus, mult };

  template <typename T>
  class Nodo;

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

  template <typename T>
  class Primitivo : public Nodo<T> {
      protected:
          T valor;
          Primitivo(T valor) : valor(valor) { }
      public:
          void printTree();
          int computeTree();
  };

  template <>
  class Primitivo<int> : public Nodo<int> {
          int valor;
      public:
          Primitivo(int valor) : valor(valors) { }
          void printTree();
          int computeTree();
  };

}
