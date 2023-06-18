%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	char* sval;
	int ival;
}

%token<sval> IDENTIFICADOR FUNCAO
%token<ival> NUMERO
%token OP_ATRIBUICAO OP_SOMA OP_SUBTRACAO OP_MULTIPLICACAO OP_DIVISAO ABRE_PARENTESES FECHA_PARENTESES
%token MAIOR MENOR IGUAL DIFERENTE ZERO INTEIRO PONTO
%token ENQUANTO SE ENTAO SENAO INICIO FIM
%token EXIT
%left OP_SOMA OP_SUBTRACAO
%left OP_MULTIPLICACAO OP_DIVISAO

%type<sval> expressao

%start programa

%%

programa:
	| programa declaracoes comandos
	;

declaracoes:
	| declaracoes declaracao
	;

declaracao:
	INTEIRO IDENTIFICADOR PONTO
	;

comandos:
	| comandos comando
	;

comando:
	atribuicao PONTO
	| condicional
	| repeticao
	;

atribuicao:
	IDENTIFICADOR '=' expressao
	{
		printf("Atribuição: %s = %s\n", $1, $3);
	}
	;

condicional:
	SE expressao MAIOR ZERO
	{
		printf("Condicional: se %s > zero\n", $2);
	}
	;

repeticao:
	ENQUANTO expressao MENOR expressao
	{
		printf("Repetição: enquanto %s < %s\n", $2, $4);
	}
	;

expressao:
	IDENTIFICADOR
	{
		$$ = $1;
	}
	| NUMERO
	{
		$$ = $1;
	}
	| expressao OP_SOMA expressao
	{
		$$ = $1;
		printf("Operador: +\n");
	}
	| expressao OP_SUBTRACAO expressao
	{
		$$ = $1;
		printf("Operador: -\n");
	}
	| expressao OP_MULTIPLICACAO expressao
	{
		$$ = $1;
		printf("Operador: x\n");
	}
	| expressao OP_DIVISAO expressao
	{
		$$ = $1;
		printf("Operador: /\n");
	}
	| ABRE_PARENTESES expressao FECHA_PARENTESES
	{
		$$ = $2;
	}
	;

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Failed to open input file: %s\n", argv[1]);
        return 1;
    }

    yyin = input_file;

    yyparse();

    fclose(input_file);

    return 0;
}
void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
