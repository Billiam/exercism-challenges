defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.downcase 
    |> String.to_char_list
    |> Enum.map(&to_int/1)
    |> validate
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0, fn {digit, position}, acc -> acc + digit * :math.pow(2, position) end)
  end
 
  defp validate(char_list) do
    cond do
      Enum.any?(char_list, &(&1 == :invalid)) -> []
      true -> char_list
    end
  end
  
  defp to_int(char) when char in '01', do: char - 48
  defp to_int(_), do: :invalid
end
