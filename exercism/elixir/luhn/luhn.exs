defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.to_integer
    |> Integer.digits
    |> Enum.reverse
    |> Enum.with_index(1)
    |> Enum.reduce(0, &parse_digit/2)
  end

  defp parse_digit(digit, acc) do
    result = digit
    |> double_alternating
    |> reduce_to_single_digit
    
    acc + result
  end
  
  defp double_alternating({digit, index}) when rem(index, 2) == 0, do: digit * 2
  defp double_alternating({digit, index}), do: digit
  
  defp reduce_to_single_digit(digit) when digit > 9, do: digit - 9
  defp reduce_to_single_digit(digit), do: digit
  
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    checksum(number) |> rem(10) === 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    offset = "#{number}0" |> checksum |> rem(10)
    last_char = 10 - offset |> rem(10)
    
    number <> to_string(last_char)
  end
end
