defmodule Roman do
  @values ~w(I V X L C D M ↁ ↂ)
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    number
    |> Integer.digits
    |> Enum.reverse
    |> Enum.map(&parse/1)
    |> Enum.with_index
    |> Enum.map(&format/1)
    |> Enum.reverse
    |> List.flatten
    |> Enum.join("")
  end
  
  defp parse(0), do: []
  defp parse(n) when n < 4, do: List.duplicate(0, n)
  defp parse(4), do: [0, 1]
  defp parse(5), do: [1]
  defp parse(n) when n < 9, do: [1 | List.duplicate(0, n - 5)]
  defp parse(9), do: [0, 2]
  
  defp format({offsets, position}) do
    numeral_base = position * 2
    offsets |> Enum.map(&roman(&1, numeral_base))
  end
  
  defp roman(n, position) do
    Enum.at(@values, n + position)
  end
end

