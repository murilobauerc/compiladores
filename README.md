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

2. Executar em um terminal os seguintes comandos:

```bash
flex elgol.l (gera lex.yy.c)
```

```bash
gcc lex.yy.c -o elgol
```

```bash
- ./elgol
```
