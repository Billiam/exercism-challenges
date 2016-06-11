defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    [a, b, c]
    |> validate
    |> unique_lengths
    |> identify
  end
  
  defp validate(lengths) do
    cond do
      zero_lengths?(lengths) -> { :error, "all side lengths must be positive" }
      invalid_lengths?(lengths) -> { :error, "side lengths violate triangle inequality" }
      true -> lengths
    end
  end
  
  defp unique_lengths({:error, _} = error), do: error
  defp unique_lengths(lengths) do
    lengths |> Enum.uniq |> length
  end
  
  defp zero_lengths?(lengths) do
    Enum.any?(lengths, &(&1 <= 0))
  end

  defp invalid_lengths?(lengths) do
    total = Enum.sum(lengths)
    
    Enum.any?(lengths, &(&1 >= total - &1))
  end
  
  defp identify({:error, _} = error), do: error
  defp identify(1), do: {:ok, :equilateral}
  defp identify(2), do: {:ok, :isosceles}
  defp identify(3), do: {:ok, :scalene}
end

