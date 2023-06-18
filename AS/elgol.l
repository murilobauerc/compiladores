%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "elgol.tab.h"
%}

identificador [A-Z][A-Za-z]{2,}
numero [1-9][0-9]*
funcao _[A-Z][A-Za-z]{2,}
espaco [ \t]+

%%
{espaco}            /* ignorar espaços em branco e tabulações */


{identificador}      {yylval.sval = strdup(yytext); return IDENTIFICADOR;}
{numero}            {yylval.ival = atoi(yytext); return NUMERO;}
{funcao}            {yylval.sval = strdup(yytext); return FUNCAO;}

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
"."                 { return PONTO; }
"("                 { return ABRE_PARENTESES; }
")"                 { return FECHA_PARENTESES; }
"="                 { return OP_ATRIBUICAO; }
"-"                 { return OP_SUBTRACAO; }
"+"                 { return OP_SOMA; }
"x"                 { return OP_MULTIPLICACAO; }
"/"                 { return OP_DIVISAO; }
"exit"              { return EXIT; }
"#"(.)*\n           /* Descartar comentários */

%%