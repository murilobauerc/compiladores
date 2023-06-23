%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

int recebeNumeroLinha();

void yyerror(const char* s);
%}

%union {
    char* sval;
    int ival;
}

%token<sval> IDENTIFICADOR FUNCAO ELGIO ZERO
%token<ival> NUMERO
%token OP_ATRIBUICAO OP_SOMA OP_SUBTRACAO OP_MULTIPLICACAO OP_DIVISAO ABRE_PARENTESES FECHA_PARENTESES
%token MAIOR MENOR IGUAL DIFERENTE INTEIRO PONTO VIRGULA
%token ENQUANTO SE ENTAO SENAO INICIO FIM

%type<sval> programa linha declaracao comandos comando atribuicao condicional laco elgol tipo_expressao expressao funcao parametros corpoDaFuncao funcaoOperando operandos expressao_matematica

%start programa

%%

programa: /* vazio */
        | programa linha 
        ;

linha: 
     | tipo_expressao resto
     ;

resto: PONTO linha
    ;

tipo_expressao: declaracao
              | atribuicao
              | condicional
              | funcao 
              | laco
              ;


declaracao: INTEIRO IDENTIFICADOR
          ;

atribuicao: IDENTIFICADOR OP_ATRIBUICAO expressao
          | FUNCAO OP_ATRIBUICAO expressao { yyerror("Uma função não pode ser alvo de uma atribuição."); }
          | ELGIO OP_ATRIBUICAO expressao_matematica
          ;

condicional: SE expressao MAIOR expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM
           | SE expressao MENOR expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM  
           | SE expressao IGUAL expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM  
           | SE expressao DIFERENTE expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM      
           ;

funcao: INTEIRO FUNCAO ABRE_PARENTESES FECHA_PARENTESES PONTO INICIO PONTO corpoDaFuncao FIM
      | INTEIRO FUNCAO ABRE_PARENTESES parametros FECHA_PARENTESES PONTO INICIO PONTO corpoDaFuncao FIM
      ;

laco: ENQUANTO expressao MAIOR expressao PONTO INICIO PONTO comandos FIM
    | ENQUANTO expressao MENOR expressao PONTO INICIO PONTO comandos FIM
    | ENQUANTO expressao IGUAL expressao PONTO INICIO PONTO comandos FIM
    | ENQUANTO expressao DIFERENTE expressao PONTO INICIO PONTO comandos FIM
    ;

elgol: ELGIO
     ;

corpoDaFuncao: /* vazio */
               | tipo_expressao PONTO
               | corpoDaFuncao tipo_expressao PONTO
               ;

funcaoOperando: FUNCAO ABRE_PARENTESES FECHA_PARENTESES
                  | FUNCAO ABRE_PARENTESES operandos FECHA_PARENTESES
                  ;

operandos: expressao
         | operandos VIRGULA expressao
         ;

parametros: declaracao
          | declaracao VIRGULA parametros 
          ;

comandos: /* vazio */ 
        | comando PONTO
        | comandos comando PONTO
        ;

comando: atribuicao
       ;


expressao_matematica: expressao_matematica OP_SOMA expressao_matematica
                      | expressao_matematica OP_SUBTRACAO expressao_matematica
                      | expressao_matematica OP_MULTIPLICACAO expressao_matematica
                      | expressao_matematica OP_DIVISAO expressao_matematica
                      | IDENTIFICADOR { $$ = $1; }
                      ;

expressao: expressao OP_SOMA expressao
         | expressao OP_SUBTRACAO expressao 
         | expressao OP_MULTIPLICACAO expressao
         | expressao OP_DIVISAO expressao
         | funcaoOperando
         | ABRE_PARENTESES expressao FECHA_PARENTESES { $$ = $2; }
         | ZERO { $$ = $1; }
         | FUNCAO { $$ = $1; }
         | IDENTIFICADOR { $$ = $1; }
         | NUMERO
         ;

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Uso: %s arquivo_de_entrada\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Falha ao abrir o arquivo de entrada: %s\n", argv[1]);
        return 1;
    }

    yyin = input_file;

    yyparse();

    printf("Parse feito com sucesso!\n");

    fclose(input_file);

    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Erro sintático na linha: %d\n", recebeNumeroLinha());
    exit(1);
}
