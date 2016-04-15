%{
#include "ast.h"
AST::Block *programRoot; /* the root node of our program AST:: */
extern int yylex();
extern void yyerror(const char* s, ...);

#include <stdio.h>
#include <stdlib.h>
#include <map>

using namespace std;

bool debug = true;
//map<string, int> tabelaDeVariaveis;

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

%token <integer> INTEIRO
%token <string> STRING
%token SOMA MULTIPLICACAO
%token DEFINICAO

/* type defines the type of our nonterminal symbols.
 * Types should match the names used in the union.
 * Example: %type<node> inteiro
 */

%type <node> definicao
%type <node> inteiro linha
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


linhas      : linha { $$ = new AST::Block(); $$->linhas.push_back($1);}
            | linhas linha { if($2 != NULL) $1->linhas.push_back($2); }
            ;

linha       : NOVA_LINHA { $$ = NULL; } /*nothing here to be used */
            | inteiro NOVA_LINHA
            | definicao NOVA_LINHA
            ;

definicao   : DEFINICAO inteiro {
               cout << *$2 << " " << $4 << endl;
              // tabelaDeVariaveis[*$2] = $4;
              // cout << tabelaDeVariaveis[*$2] << endl;
            }


inteiro     : INTEIRO { $$ = new AST::Integer($1); }
            | inteiro SOMA inteiro {
                $$ = new AST::BinOp($1,AST::plus,$3);
                if(debug) printf("        SOMA\n") ;
              }
            | inteiro MULTIPLICACAO inteiro {
                $$ = new AST::BinOp($1,AST::mult, $3);
                if(debug) printf("        MULTILICAÇÃO\n") ;
              }
            | inteiro error { yyerrok; $$ = $1; } /*just a point for error recovery*/
            ;

%%
