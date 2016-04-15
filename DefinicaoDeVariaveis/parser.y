%{
#include "ast.h"

AST::Block *programRoot; /* the root node of our program AST:: */
extern int yylex();
extern void yyerror(const char* s, ...);

#include <stdio.h>
#include <stdlib.h>

using namespace AST;
using namespace std;

#define VARIAVEL_INDEFINIDA -666;
bool debug = true;

%}

/* yylval == %union
 * union informs the different ways we can store data
 */
%union {
    int integer;
    std::string *string;

    AST::Node *node;
    AST::Block *block;
}

// token defines our terminal symbols (tokens).

%token DEBUG
%token NOVA_LINHA
%token VIRGULA
DEU BOA
%token <integer> INTEIRO
%token <string> STRING

%token DEFINICAO
%token ATRIBUICAO

%token SOMA MULTIPLICACAO

/* type defines the type of our nonterminal symbols.
 * Types should match the names used in the union.
 * Example: %type<node> inteiro
 */

%type <node> definicao
%type <node> definicao_multipla
%type <node> atribuicao

%type <node> inteiro

%type <node> linha
%type <block> linhas program

/* Operator precedence for mathematical operators
 * The latest it is listed, the highest the precedence
 */

%left DEFINICAO ATRIBUICAO
%left SOMA
%left MULTIPLICACAO
%nonassoc errord

/* Starting rule*/

%start program

%%

program     : linhas { programRoot = $1; }
            ;


linhas      : linha { $$ = new Block(); $$->linhas.push_back($1);}
            | linhas linha { if($2 != NULL) $1->linhas.push_back($2); }
            ;

linha       : NOVA_LINHA { $$ = NULL; } /*nothing here to be used */
            | inteiro NOVA_LINHA
            | definicao NOVA_LINHA
            | definicao_multipla NOVA_LINHA
            | atribuicao NOVA_LINHA
            ;

definicao   : DEFINICAO STRING {
                $$ = new Identificador(*$2);

                tabelaDeVariaveis[*$2] = VARIAVEL_INDEFINIDA;
                cout << "DEFINICAO" << endl;
              }
            ;

definicao_multipla  : definicao VIRGULA STRING {
                      $$ = new Identificador(*$3);

                      tabelaDeVariaveis[*$3] = VARIAVEL_INDEFINIDA;
                      cout << "DEFINICAO" << endl;
                    }
                    ;

atribuicao  : STRING ATRIBUICAO inteiro {
                if(tabelaDeVariaveis[*$1]){
                  tabelaDeVariaveis[*$1] = $3->computeTree();
                  cout << "ATRIBUICAO" << endl;
                } else{
                  cout << "Variável '" << *$1 << "' não definida." << endl;
                }
              }
            | definicao ATRIBUICAO inteiro {

            }


inteiro     : INTEIRO { $$ = new Integer($1); }
            | inteiro SOMA inteiro {
                $$ = new BinOp($1, AST::plus,$3);
                if(debug) cout << "SOMA" << endl;
              }
            | inteiro MULTIPLICACAO inteiro {
                $$ = new BinOp($1, AST::mult, $3);
                if(debug) cout << "MULTIPLICACAO" << endl;
              }
            | inteiro error { yyerrok; $$ = $1; } /*just a point for error recovery*/
            ;

%%
