%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

void yyerror(const char* s);

int recebe_numero_linha;
int numero_linha = 1;

#include "elgol.tab.h"
%}

identificador [A-Z][A-Za-z]{2,}
numero [1-9][0-9]*|0
funcao _[A-Z][A-Za-z]{2,}
espaco [\t]+

numero_invalido [0-9]+[A-Za-z]+

%%

{identificador}      {yylval.sval = strdup(yytext); return IDENTIFICADOR;}
{numero}            {yylval.ival = atoi(yytext); return NUMERO;}
{funcao}            {yylval.sval = strdup(yytext); return FUNCAO;}
  
{numero_invalido}  { yyerror("Número inválido."); }

"inteiro"           { return INTEIRO; }
"zero"              { return ZERO; }
"enquanto"          { return ENQUANTO; }
"se"                { return SE; }
"entao"             { return ENTAO; }
"senao"             { return SENAO; }
"inicio"            { return INICIO; }
"fim"                { return FIM; }
"maior"             { return MAIOR; }
"menor"             { return MENOR; }
"igual"             { return IGUAL; }
"diferente"         { return DIFERENTE; }
"elgio"             { return ELGIO; }
"."                 { return PONTO; }
","                 { return VIRGULA;}
"("                 { return ABRE_PARENTESES; }
")"                 { return FECHA_PARENTESES; }
"="                 { return OP_ATRIBUICAO; }
"-"                 { return OP_SUBTRACAO; }
"+"                 { return OP_SOMA; }
"x"                 { return OP_MULTIPLICACAO; }
"/"                 { return OP_DIVISAO; }
\n                  { numero_linha++; }
"#"(.)*             /* Descartar comentários */

{espaco}            /* ignorar espaços em branco e tabulações */

%%

int recebeNumeroLinha () {
    return numero_linha;
}