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

/* token defines our terminal symbols (tokens).
 */
%token <integer> T_INT
%token T_PLUS T_MULT T_NL
%token DEBUG

/* type defines the type of our nonterminal symbols.
 * Types should match the names used in the union.
 * Example: %type<node> expr
 */
%type <node> expr line
%type <block> lines program

/* Operator precedence for mathematical operators
 * The latest it is listed, the highest the precedence
 */
%left T_PLUS
%left T_MULT
%nonassoc errord

/* Starting rule
 */
%start program

%%

program : lines { programRoot = $1; }
        ;


lines   : line { $$ = new AST::Block(); $$->lines.push_back($1); }
        | lines line { if($2 != NULL) $1->lines.push_back($2); }
        ;

line    : T_NL { $$ = NULL; } /*nothing here to be used */
        | expr T_NL /*$$ = $1 when nothing is said*/
        ;

expr    : T_INT { $$ = new AST::Integer($1); }
        | expr T_PLUS expr {
            $$ = new AST::BinOp($1,AST::plus,$3);
            if(debug) printf("        SOMA identificada\n") ;
          }
        | expr T_MULT expr {
            $$ = new AST::BinOp($1,AST::mult, $3);
            if(debug) printf("        MULTILICAÇÃO identificada\n") ;
          }
        | expr error { yyerrok; $$ = $1; } /*just a point for error recovery*/
        ;

%%
