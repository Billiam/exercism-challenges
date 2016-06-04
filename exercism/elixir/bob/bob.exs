defmodule Bob do
  def hey(input) do
    input |> listen |> respond
  end
  
  defp listen(input) do
    trimmed = String.strip(input)
    cond do
      trimmed == "" -> :silence
      String.ends_with?(trimmed, "?") -> :question
      Regex.match?(~r/\p{L}/i, trimmed) and String.upcase(trimmed) == trimmed -> :yelling
      true -> :anything
    end
  end
  
  defp respond(:silence) do
    "Fine. Be that way!"
  end
  
  defp respond(:question) do
    "Sure."
  end
  
  defp respond(:yelling) do
    "Whoa, chill out!"
  end
  
  defp respond(_) do
    "Whatever."
  end
end
