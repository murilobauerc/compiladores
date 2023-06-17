### Como executar exercício AP1

Pré-requisitos:

- Instalar Elixir (https://elixir-lang.org/install.html)
- Executar:

```bash
cd compiladores/ap1 && elixir compiladores_ex2.ex
```

### Como executar Trabalho Final de Compiladores

Para executar o trabalho final da AS com Flex (analisador léxico) e Bison (analisador semantico):

1. Pré requisitos:

   - Instalar flex (no macOS `brew install flex`)

2. Executar os passos para analise léxica em um terminal:

Acessar a pasta do projeto:

```sh
cd compiladores/AS
```

Para executar o flex e gerar o código em C:

```sh
flex elgol.l
```

Para compilar o arquivo compilado pelo flex:

```sh
gcc lex.yy.c -o elgol
```

Para executar o arquivo compilado:

```sh
./elgol
```

3. Após, executar passos para gerar a análise semantica em um terminal:

```sh
bison -d elgol.y
```

4. Para vincular o analisador léxico (Flex) e o analisador sintático (Bison) e executar o código, pode ser compilado e vinculado os arquivos `elgol.tab.c` e `lex.yy.c` da seguinte forma:

```sh
gcc -o elgol elgol.tab.c lex.yy.c -lfl
```

5. Para executar o arquivo compilado:

```sh
./elgol
```

6. Coloque como entrada o código Elgol, exemplo:

```text
inteiro Lixo. # minha variavel
inteiro Teste.
Lixo = 34.
se Lixo maior zero.
entao.
inicio.
    Lixo = zero.
    Teste = 300.
fim.
```
