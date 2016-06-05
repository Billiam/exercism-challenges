defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    string |> words |> first_letters |> Enum.join() |> String.upcase
  end
  
  defp words(string) do
    Regex.split(~r/\P{L}+|\p{Ll}(?=\p{Lu})/, string)
  end
  
  defp first_letters(word_list) do
    Enum.map(word_list, &String.first/1)
  end
end
