%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>

	extern int yylex();
	extern int yyparse();
	extern FILE* yyin;
	void yyerror(const char* s);

	void simplificarFracao(int *fracao);
%}

%union {
	int val_inteiro;
	int val_racional[2];
}

//token (Terminal)
%token<val_inteiro> INTEIRO
%token<val_racional> RACIONAL

%token SOMA SUBTRACAO MULTIPLICACAO DIVISAO
%token EXPONENCIACAO

%token FRACAO

%token PARENTESES
%token NOVA_LINHA SAIR

//token (Não-Terminal)
%type<val_inteiro> inteiro
%type<val_racional> racional

//Precedência
%left SOMA SUBTRACAO
%left	MULTIPLICACAO DIVISAO
%right FRACAO
%right NEGATIVO
%right EXPONENCIACAO

%% //Gramática

calculo :
        | calculo linha
;

linha   : NOVA_LINHA
		| inteiro 								{ printf("\tResultado = %i \n", $1); }
		| racional 								{ printf("\tResultado = %i / %i \n", $1[0], $1[1]); }
		| SAIR 									{ printf("falow\n"); exit(0); }
;

inteiro : T_INTEIRO             					{ $$ = $1; }
		| inteiro SOMA inteiro  					{ $$ = $1 + $3; }
		| inteiro SUBTRACAO inteiro  				{ $$ = $1 - $3; }
		| inteiro MULTIPLICACAO inteiro 			{ $$ = $1 * $3; }
		| inteiro EXPONENCIACAO inteiro				{ $$ = pow($1, $3); }
		| SUBTRACAO inteiro %prec NEGATIVO			{ $$ = -$2; }
		| PARENTESES inteiro PARENTESES				{ $$ = $2; }
;

racional : inteiro FRACAO inteiro					{ $$[0] = $1; $$[1] = $3; if($3 == 0){ printf("ERRO: divisão por zero\n"); exit(1);}; simplificarFracao(&$$[0]);}
		| inteiro FRACAO SUBTRACAO inteiro			{ $$[0] = -$1; $$[1] = $4; }

		| racional SOMA racional					{ $$[0] = $1[0] * $3[1] + $1[1] * $3[0]; $$[1] = $1[1] * $3[1];}
		| racional SUBTRACAO racional				{ $$[0] = $1[0] * $3[1] - $1[1] * $3[0]; $$[1] = $1[1] * $3[1];}

		| racional MULTIPLICACAO racional			{ $$[0] = $1[0] * $3[0]; $$[1] = $1[1] * $3[1]; }
		| racional DIVISAO racional					{ $$[0] = $1[0] * $3[1]; $$[1] = $1[1] * $3[0]; }

		| racional EXPONENCIACAO inteiro			{ $$[0] = pow($1[0], $3); $$[1] = pow($1[1], $3);}

 		| PARENTESES racional PARENTESES 			{ $$[0] = $2[0]; $$[1] = $2[1]; }

//					| racional SOMA inteiro									{ $$[0] = $1[0] + $1[1] * $3; $$[1] = $1[1];}
//					| inteiro DIVISAO inteiro								{ $$[0] = $1; $$[1] = $3; }
//					| racional DIVISAO inteiro							{ $$[0] = $1[0]; $$[1] = $1[1] * $3;}
//					| inteiro DIVISAO racional							{ $$[0] = $1 * $3[1]; $$[1] = $3[0];}
;

%% //Código

int main() {
    yyin = stdin;
    do {
        yyparse();
    } while(!feof(yyin));

    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Erro durante o parsing: %s\n", s);
    exit(1);
}

void simplificarFracao(int *fracao){
	int valor = mdc(*(fracao), *(fracao + 1));

	*(fracao) = *(fracao) / valor;
	*(fracao + 1) = *(fracao + 1) / valor;
}

//REFERÊNCIA: http://www.devfuria.com.br/logica-de-programacao/mdc/
int mdc(int num1, int num2) {

    int resto;

    do {
        resto = num1 % num2;

        num1 = num2;
        num2 = resto;

    } while (resto != 0);

    return num1;
}
