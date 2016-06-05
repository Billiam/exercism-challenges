defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence |> word_list |> normalize |> word_count
  end
  
  defp word_list(sentence) do
    Regex.split(~r/(*UTF)[^\p{L}\p{N}\p{Pd}]+/, sentence) |> Enum.reject(&(&1 == ""))
  end
  
  defp normalize(word_list) do
    Enum.map(word_list, &String.downcase/1)
  end
  
  defp word_count(word_list) do
    Enum.group_by(word_list, &(&1)) |> Enum.map(fn {k, v} -> {k, length(v)} end) |> Enum.into(%{})
  end
end
