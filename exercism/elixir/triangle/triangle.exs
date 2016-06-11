defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    [a, b, c]
    |> validate
    |> identify
  end
  
  defp validate(lengths) do
    cond do
      zero_lengths?(lengths) -> { :error, "all side lengths must be positive" }
      invalid_lengths?(lengths) -> { :error, "side lengths violate triangle inequality" }
      true -> lengths
    end
  end
  
  defp zero_lengths?(lengths) do
    Enum.any?(lengths, &(&1 <= 0))
  end

  defp invalid_lengths?(lengths) do
    total = Enum.sum(lengths)
    
    Enum.any?(lengths, &(&1 >= total - &1))
  end
  
  defp identify({:error, _} = error), do: error
  defp identify([a, b, c]) when a == b and a == c, do: {:ok, :equilateral}
  defp identify([a, b, c]) when a == b or a == c or b == c, do: {:ok, :isosceles}
  defp identify(_), do: {:ok, :scalene}
end

