defmodule Simbolos do
  @moduledoc """
  Este módulo contém as funções para a leitura de um arquivo e a geração de uma tabela de símbolos.
  Para mais informacoes, veja a documentação no README.md
  """

  def tokenize(string) do
    string
    |> String.split(~r/\s+/) # Quebra a string em palavras separadas por espaço
    |> Enum.map(&parse_token/1) # Converte cada palavra em um token
    |> Enum.reject(&is_nil/1) # Remove tokens inválidos (retornados como nil)
  end

  @doc """
  Converte uma palavra em um token baseado em regex.
  Retorna nil caso a palavra não seja um token válido.
  """
  def parse_token(token) do
    cond do
      Regex.match?(~r/^(int|double|char|float|if|while|for)$/, token) -> {:reservada, token}
      Regex.match?(~r/^[A-Z][A-Za-z]*$/, token) -> {:identificador, token}
      Regex.match?(~r/^([0-9]+(,[0-9]+)?|[0-9]+)\)?$/ , token) -> {:número, token}
      true -> nil # Token inválido
    end
  end

  def generate_symbol_table(tokens) do
    tokens
    |> Enum.reduce(%{}, fn {type, value}, acc ->  
      Map.update(acc, value, type, fn existing_type ->
        if existing_type == type, do: existing_type, else: :erro
      end)
    end)
  end

  def print_symbol_table(symbol_table) do
    IO.puts("Entrada | Valor | Tipo")
    symbol_table
    |> Map.to_list()
    |> Enum.each(fn {value, type} ->
      IO.puts("#{Enum.find_index(symbol_table, fn {v, _} -> v == value end)}\t#{value}\t#{type}")
    end)
  end

  def main do
    input = """
      int Teste
      double lixo
      int Outroteste
      char Lixo
      double teste
      int teste
      float test
      float Test

      Lixo = 45

      Mesmo = 34,567

      while ( Mesmo < 600 )
    """

    IO.puts("Executando o código para a entrada #{input}:")

    tokens = Simbolos.tokenize(input)
    symbol_table = Simbolos.generate_symbol_table(tokens)
    Simbolos.print_symbol_table(symbol_table)
  end
end

Simbolos.main
