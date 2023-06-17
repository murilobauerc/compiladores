%{
#include <stdio.h>
#include <stdlib.h>
#include "elgol.tab.h"

int Lixo;
int Teste;

void execute_command(int command_type) {
    switch (command_type) {
        case IDENTIFICADOR:
            printf("Identificador: %s\n", $1);
            break;
        case NUMERO:
            printf("Número: %s\n", $1);
            break;
        case ATRIBUICAO:
            printf("Atribuição: %s = %s\n", $1, $3);
            break;
        case CONDICIONAL:
            printf("Condicional: se %s > zero\n", $2);
            break;
        case REPETICAO:
            printf("Repetição: enquanto %s < %s\n", $2, $4);
            break;
        case OPERADOR:
            printf("Operador: %s\n", $1);
            break;
        case PONTO:
            printf("Ponto: .\n");
            break;
        default:
            printf("Nao é uma expressao válida na linguagem Elgol: %s\n", yytext);
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

atribuicao: IDENTIFICADOR '=' expressao
          {
            execute_command(ATRIBUICAO);
          }
          ;

condicional: SE expressao MAIOR ZERO ENTAO INICIO comandos FIM
            {
              execute_command(CONDICIONAL);
            }
            ;

repeticao: ENQUANTO expressao MENOR NUMERO INICIO comandos FIM
          {
            execute_command(REPETICAO);
          }
          ;

expressao: expressao '+' expressao
         | expressao '-' expressao
         | expressao 'x' expressao
         | expressao '/' expressao
         | NUMERO
         | IDENTIFICADOR
         | IDENTIFICADOR '(' expressoes ')'
         ;

expressoes: expressoes ',' expressao
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