defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    hex
    |> String.downcase 
    |> String.to_char_list
    |> Enum.map(&to_int/1)
    |> validate
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0, fn {digit, position}, acc -> acc + digit * :math.pow(16, position)
    end)
  end
 
  defp validate(char_list) do
    cond do
      Enum.any?(char_list, &(&1 == :invalid)) -> []
      true -> char_list
    end
  end
  
  defp to_int(char) when char >= 97 and char < 103, do: char - 97 + 10
  defp to_int(char) when char >= 48 and char < 59, do: char - 48
  defp to_int(_), do: :invalid
end
