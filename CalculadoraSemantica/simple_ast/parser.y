%{
#include "ast.h"
AST::Block *programRoot; /* the root node of our program AST:: */
extern int yylex();
extern void yyerror(const char* s, ...);

#include <stdio.h>
#include <stdlib.h>

bool debug = true;
%}

/* yylval == %union
 * union informs the different ways we can store data
 */
%union {
    int integer;
    AST::Node *node;
    AST::Block *block;
}

// token defines our terminal symbols (tokens).

%token DEBUG
%token NOVA_LINHA

%token <integer> INTEIRO
%token SOMA MULTIPLICACAO

/* type defines the type of our nonterminal symbols.
 * Types should match the names used in the union.
 * Example: %type<node> inteiro
 */
%type <node> inteiro linha
%type <block> linhas program

/* Operator precedence for mathematical operators
 * The latest it is listed, the highest the precedence
 */
%left SOMA
%left MULTIPLICACAO
%nonassoc errord

/* Starting rule
 */
%start program

%%

program : linhas { programRoot = $1; }
        ;


linhas  : linha { $$ = new AST::Block(); $$->linhas.push_back($1); }
        | linhas linha { if($2 != NULL) $1->linhas.push_back($2); }
        ;

linha    : NOVA_LINHA { $$ = NULL; } /*nothing here to be used */
        | inteiro NOVA_LINHA /*$$ = $1 when nothing is said*/
        ;

inteiro : INTEIRO { $$ = new AST::Integer($1); }
        | inteiro SOMA inteiro {
            $$ = new AST::BinOp($1,AST::plus,$3);
            if(debug) printf("        SOMA identificada\n") ;
          }
        | inteiro MULTIPLICACAO inteiro {
            $$ = new AST::BinOp($1,AST::mult, $3);
            if(debug) printf("        MULTILICAÇÃO identificada\n") ;
          }
        | inteiro error { yyerrok; $$ = $1; } /*just a point for error recovery*/
        ;

%%
