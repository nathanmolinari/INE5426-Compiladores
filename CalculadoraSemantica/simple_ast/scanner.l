%{
#include <string>
#include "ast.h"
#include "parser.h"
extern int yylineno;
void yyerror(const char* s, ...);
%}

%option noyywrap nodefault yylineno

digito [0-9]+

%%

"debug"             {return DEBUG;}

[ \t]               ; //ignores spaces
\n                  {return NOVA_LINHA;}

{digito}            {yylval.integer = std::atoi(yytext); return INTEIRO;}

"+"                 {return SOMA;}
"*"                 {return MULTIPLICACAO;}

.                   {yyerror("Unknown token! %c\n", *yytext);} /*complains about every unknown character*/

%%

void yyerror(const char *s, ...){
    va_list ap;
    va_start(ap, s);
    std::fprintf(stderr, "Line %d: error: ", yylineno);
    std::vfprintf(stderr, s, ap);
}
