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
cd compiladores-main/AS
```

Para executar o Flex/Bison, use o Makefile como guia:

```sh
make all
```

Depois só executar o arquivo de entrada, exemplo:

```sh
./elgol meu_codigo_elgol.txt
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
