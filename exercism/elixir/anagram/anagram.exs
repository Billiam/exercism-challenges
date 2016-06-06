defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    criterion = sorted_word(base)
    
    candidates 
    |> reject_match(String.downcase(base))
    |> select_anagrams(criterion)
  end
  
  defp select_anagrams(candidates, target) do
    Enum.filter(candidates, &(sorted_word(&1) === target))
  end
  
  defp reject_match(candidates, base) do
    Enum.reject(candidates, &(String.downcase(&1) === base))
  end
  
  defp sorted_word(word) do
    word
    |> String.downcase
    |> to_char_list
    |> Enum.sort
  end
end
