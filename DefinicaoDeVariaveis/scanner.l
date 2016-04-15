%{
#include <string>
#include "ast.h"
#include "parser.h"

using namespace std;

extern int yylineno;

void yyerror(const char* s, ...);
%}

%option noyywrap nodefault yylineno

digito [0-9]+
string [a-zA-Z]+

%%

"debug"             {return DEBUG;}

[ \t]               ; //ignora espaços
\n                  {return NOVA_LINHA;}

"def"               {return DEFINICAO;}
"="                 {return ATRIBUICAO;}
","                 {return VIRGULA;}

"+"                 {return SOMA;}
"*"                 {return MULTIPLICACAO;}

{digito}            {yylval.integer = atoi(yytext); return INTEIRO;}
{string}            {yylval.string = new string(yytext); return STRING;}

.                   {yyerror("Caracter desconhecido: %c\n", *yytext);}

%%

void yyerror(const char *s, ...){
    va_list ap;
    va_start(ap, s);
    fprintf(stderr, "Line %d: error: ", yylineno);
    vfprintf(stderr, s, ap);
}
