defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size < 0, do: raise ArgumentError
  def largest_product(_, 0), do: 1
  def largest_product(number_string, size) do
    if String.length(number_string) < size, do: raise ArgumentError
    
    number_string
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk(size, 1)
    |> Enum.map(&multiply_list/1)
    |> Enum.max
  end
  
  defp multiply_list(list) do
    list
    |> Enum.reduce(1, &(&1 * &2))
  end
end