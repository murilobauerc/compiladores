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
%token EXIT NOVA_LINHA

%type<sval> programa linha declaracao comandos comando atribuicao condicional expressao

%start programa

%%

programa: /* vazio */ {}
    | programa linha 
    ;

linha: expressao NOVA_LINHA
     | NOVA_LINHA
     ;

expressao: declaracao
         | atribuicao
         | condicional
         ;

declaracao: INTEIRO IDENTIFICADOR PONTO
    ;

atribuicao: IDENTIFICADOR OP_ATRIBUICAO expressao    

condicional: SE expressao ENTAO comandos FIM
    | SE expressao ENTAO comandos SENAO comandos FIM
    ;

comandos: comando PONTO
    | comandos comando PONTO
    ;

comando: atribuicao
    ;

expressao: IDENTIFICADOR { $$ = $1; }
    | NUMERO { $$ = $1; }
    | expressao OP_SOMA expressao { $$ = $1 + $3; }
    | expressao OP_SUBTRACAO expressao { $$ = $1 - $3; }
    | expressao OP_MULTIPLICACAO expressao { $$ = $1 * $3; }
    | expressao OP_DIVISAO expressao { $$ = $1 / $3; }
    | ABRE_PARENTESES expressao FECHA_PARENTESES
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
