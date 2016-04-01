%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calculadora_basica.tab.h"

%}

digito  [0-9]

%%

[ \t]       ; // ignora espaços em branco
{digito}+   {yylval.val_inteiro = atoi(yytext); return T_INTEIRO;}
\n          {return NOVA_LINHA;}

"+"         {return SOMA;}
"-"         {return SUBTRACAO;}
"*"         {return MULTIPLICACAO;}
":"         {return DIVISAO;}

"/"         {return FRACAO;}

"**"        {return EXPONENCIACAO;}

"("         {return PARENTESES;}
")"         {return PARENTESES;}
"sair"     {return SAIR;}

%%
