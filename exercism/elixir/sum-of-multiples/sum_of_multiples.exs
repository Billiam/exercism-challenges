defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(&multiples_to(&1, limit))
    |> List.flatten
    |> Enum.uniq
    |> Enum.sum
  end
  
  defp multiples_to(num, limit) when num > limit, do: 0
  defp multiples_to(num, limit) do
    1..div(limit - 1, num)
    |> Enum.map(&(&1 * num))
  end
end
iex