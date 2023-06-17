### Como executar exercício AP1

Pré-requisitos:

- Instalar Elixir (https://elixir-lang.org/install.html)
- Executar:

```bash
cd compiladores/ap1 && elixir compiladores_ex2.ex
```

### Como executar Trabalho Final de Compiladores

Para executar o trabalho final da AS com Flex (analisador léxico):

1. Pré requisitos:

   - Instalar flex (no macOS `brew install flex`)

2. Executar em um terminal:

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
- ./elgol
```
