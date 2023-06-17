%{
#include <stdio.h>
#include <stdlib.h>
#include "elgol.tab.h"

void execute_command(int command_type, char* arg1, char* arg2) {
    switch (command_type) {
        case IDENTIFICADOR:
            printf("Identificador: %s\n", arg1);
            break;
        case NUMERO:
            printf("Número: %s\n", arg1);
            break;
        case ATRIBUICAO:
            printf("Atribuição: %s = %s\n", arg1, arg2);
            break;
        case CONDICIONAL:
            printf("Condicional: se %s > zero\n", arg1);
            break;
        case REPETICAO:
            printf("Repetição: enquanto %s < %s\n", arg1, arg2);
            break;
        case OPERADOR:
            printf("Operador: %s\n", arg1);
            break;
        case PONTO:
            printf("Ponto: .\n");
            break;
        case INICIO:
            printf("Inicio\n");
            break;
        case FIM:
            printf("Fim\n");
            break;
        case MAIOR:
            printf("Maior\n");
            break;
        case MENOR:
            printf("Menor\n");
            break;
        case IGUAL:
            printf("Igual\n");
            break;
        case DIFERENTE:
            printf("Diferente\n");
            break;
        default:
            printf("Não é uma expressão válida na linguagem Elgol: %s\n", yytext);
            break;
    }
}
%}

%token INTEIRO ZERO ENQUANTO SE ENTAO SENAO INICIO FIM MAIOR MENOR IGUAL DIFERENTE PONTO
%token IDENTIFICADOR NUMERO
%left '+' '-'
%left 'x' '/'
%right '='

%%

programa: declaracoes comandos
        ;

declaracoes: declaracoes declaracao
           |
           ;

declaracao: tipo IDENTIFICADOR PONTO
          ;

tipo: INTEIRO
    | ZERO
    ;

comandos: comandos comando
        |
        ;

comando: atribuicao PONTO
       | condicional
       | repeticao
       ;

atribuicao: IDENTIFICADOR '=' expressao PONTO
          {
            execute_command(ATRIBUICAO, $1, $3);
          }
          ;

condicional: SE expressao MAIOR ZERO ENTAO PONTO
            {
              execute_command(CONDICIONAL, $2, "zero");
            }
            ;

repeticao: ENQUANTO expressao MENOR expressao PONTO
          {
            execute_command(REPETICAO, $2, $4);
          }
          ;

expressao: IDENTIFICADOR
         | expressao '+' expressao
         | expressao '-' expressao
         | expressao 'x' expressao
         | expressao '/' expressao
         | IDENTIFICADOR '(' expressoes ')' 
         ;

expressoes: expressao ',' expressoes
          | expressao
          ;

%%

int main() {
    printf("Digite algo: ");
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    fprintf(stderr, "Erro de análise: %s\n", msg);
    return 1;
}