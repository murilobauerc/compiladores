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

%token<sval> IDENTIFICADOR FUNCAO ELGIO NUMERO ZERO
%token OP_ATRIBUICAO OP_SOMA OP_SUBTRACAO OP_MULTIPLICACAO OP_DIVISAO ABRE_PARENTESES FECHA_PARENTESES
%token MAIOR MENOR IGUAL DIFERENTE INTEIRO PONTO VIRGULA
%token ENQUANTO SE ENTAO SENAO INICIO FIM

%type<sval> programa linha declaracao comandos comando atribuicao condicional elgol tipo_expressao expressao

%start programa

%%

programa: /* vazio */
        | programa linha 
        ;

linha: 
     | tipo_expressao resto
     ;

resto: PONTO linha

tipo_expressao: declaracao
         | atribuicao
         | condicional
         | funcao
         | elgol
         ;

elgol: ELGIO { $$ = $1; }
     ;

declaracao: INTEIRO IDENTIFICADOR
          ;

atribuicao: IDENTIFICADOR OP_ATRIBUICAO expressao
          | FUNCAO OP_ATRIBUICAO expressao { yyerror("Uma função não pode ser alvo de uma atribuição."); }
          ;

condicional: SE expressao MAIOR expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM
            | SE expressao MENOR expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM  
            | SE expressao IGUAL expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM  
            | SE expressao DIFERENTE expressao PONTO ENTAO PONTO INICIO PONTO comandos FIM PONTO SENAO PONTO INICIO PONTO comandos FIM      
           ;

funcao: INTEIRO FUNCAO ABRE_PARENTESES parametros FECHA_PARENTESES 
      ;

parametros: /* vazio */
           | declaracao
           | parametros VIRGULA declaracao
           ;

comandos: /* vazio */ 
        | comando PONTO
        | comandos comando PONTO
        ;

comando: atribuicao
       ;

expressao: 
         | expressao OP_SOMA expressao { $1; $3; }
         | expressao OP_SUBTRACAO expressao { $1; $3; }
         | expressao OP_MULTIPLICACAO expressao { $1; $3; }
         | expressao OP_DIVISAO expressao { $1; $3; }
         | ABRE_PARENTESES expressao FECHA_PARENTESES { $$ = $2; }
         | ZERO { $$ = $1; }
         | IDENTIFICADOR { $$ = $1; }
         | FUNCAO { $$ = $1; }
         | NUMERO { $$ = $1; }
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

    printf("Parse feito com sucesso!\n");

    fclose(input_file);

    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}
