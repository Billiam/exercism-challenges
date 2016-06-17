defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    range = min_factor..max_factor
    
    (for x <- min_factor..max_factor,
        y <- x..max_factor,
        palindrome?(x*y),
        do: [x,y])
    |> Enum.group_by(fn [x, y] -> x * y end)
  end
  
  defp palindrome?(num) do
    digits = num |> Integer.digits

    Enum.reverse(digits) == digits
  end
end
