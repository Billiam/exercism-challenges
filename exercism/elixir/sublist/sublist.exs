defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) do
    cond do
      check_list(a, b) -> :superlist
      check_list(b, a) -> :sublist
      true -> :unequal
    end
  end
  
  defp check_list(a, b) do
    cond do
      length(a) < length(b) -> false
      matches?(a, b) -> true
      true -> check_list(tl(a), b)
    end
  end
  
  defp matches?(a, b) do
    Enum.take(a, length(b)) === b
  end
end
