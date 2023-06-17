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

2. Executar em uma linha de comando:

```bash
- flex elgol.l (gera lex.yy.c)
- gcc lex.yy.c -o elgol
- ./elgol
```
