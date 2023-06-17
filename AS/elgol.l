%{
   /* definitions */
%}

/* Aqui definimos as regras do nosso analisador léxico baseado nas propriedades da linguagem Elgol */
%% 

[A-Z][A-Za-z]{2,}   { printf("Identificador: %s\n", yytext); }
[1-9][0-9]*   { printf("Numero inteiro: %s\n", yytext); }
_[A-Z][A-Za-z]{2,}*  { printf("Funcao: %s\n", yytext); }
elgio         { printf("Palavra Reservada: elgio\n"); }
inteiro       { printf("Palavra Reservada: inteiro\n"); }
zero          { printf("Palavra Reservada: zero\n"); }
enquanto      { printf("Palavra Reservada: enquanto\n"); }
se            { printf("Palavra Reservada: se\n"); }
entao         { printf("Palavra Reservada: entao\n"); }
senao         { printf("Palavra Reservada: senao\n"); }
inicio        { printf("Palavra Reservada: inicio\n"); }
fim            { printf("Palavra Reservada: fim\n"); }
maior         { printf("Palavra Reservada: maior\n"); }
menor         { printf("Palavra Reservada: menor\n"); }
igual         { printf("Palavra Reservada: igual\n"); }
diferente     { printf("Palavra Reservada: diferente\n"); }
[-+=x/]       { printf("Operador: %c\n", yytext[0]); }
\(            { printf("Abre parênteses\n"); }
\)            { printf("Fecha parênteses\n"); }
\.            { printf("Ponto: .\n"); }
#.*           { /* Ignorar comentários */ }
.            { printf("Nao é uma expressao válida na linguagem Elgol: %s\n", yytext); }
\n            {return 0;}

%%

yywrap() {}

int main() {
    printf("Digite algo: ");
    yylex();

    return 0;
}

