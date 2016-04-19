%{
    #include "parser.h"
    #include "AnaliseSemantica/AnaliseSemantica.h"

    #include <string>

    using namespace std;

    extern int yylineno;
    void yyerror(const char* s, ...);
%}

%option noyywrap nodefault yylineno

number [0-9]+
string [a-zA-Z]+

%%

[ \t]               ; //ignora espaços
\n                  {return NOVA_LINHA;}
";"                 {return NOVA_LINHA;}

"def"               {return DEFINICAO;}
"="                 {return ATRIBUICAO;}

"+"                 {return SOMA;}
"-"                 {return SUBTRACAO;}
"*"                 {return MULTIPLICACAO;}
":"                 {return DIVISAO;}

","                 {return VIRGULA;}
"."                 {return PONTO;}

"("                 {return ABRE_PARENTESES;}
")"                 {return FECHA_PARENTESES;}
"{"                 {return ABRE_CHAVES;}
"}"                 {return FECHA_CHAVES;}

{number}            {yylval.integer = atoi(yytext); return INTEIRO;}
{string}            {yylval.string = new string(yytext); return STRING;}

.                   {yyerror("Caracter desconhecido: %c\n", *yytext);}

%%

void yyerror(const char *s, ...){
    va_list ap;
    va_start(ap, s);
    fprintf(stderr, "[Linha %d] Erro: ", yylineno);
    vfprintf(stderr, s, ap);
}
