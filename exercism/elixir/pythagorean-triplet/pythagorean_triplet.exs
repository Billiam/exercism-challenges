defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: Enum.sum(triplet)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    triplet
    |> Enum.reduce(1, &(&1 * &2))
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?(list) do
    list
    |> Enum.map(&(&1 * &1))
    |> pythagorean_squares?
  end
  
  defp pythagorean_squares?([a, b, c]) do
    a + b == c
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    squares = min..max |> Enum.map(&(&1 * &1))
    
    combinations(squares)
    |> Enum.filter(&pythagorean_squares?/1)
    |> Enum.uniq
    |> Enum.map(&Enum.map(&1, fn n -> :math.sqrt(n) |> trunc end))
    |> Enum.sort
  end
  
  defp combinations(list) do
    for x <- list,
        y <- list,
        z <- list,
        do: Enum.sort([x, y, z])
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, target) do
   generate(min, max)
   |> Enum.filter(&(sum(&1) == target))
  end
end