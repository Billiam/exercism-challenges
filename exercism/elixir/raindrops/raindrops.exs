defmodule Raindrops do
  @phrases %{3 => "Pling", 5 => "Plang", 7 => "Plong"}
  
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    phrases = number
    |> factors_for
    |> parse
    |> render(number)
  end
  
  defp parse(factors) do
    for {num, word} <- @phrases, num in factors, do: word
  end
  
  defp render([], n), do: to_string(n)
  defp render(phrases, _), do: Enum.join(phrases, "")
  
  #
  # From previous exercise
  #
  defp factors_for(number) do
    find_factors(number) |> Enum.reverse
  end
  
  defp find_factors(number, divisor \\ 2, primes \\ []) when number < divisor, do: primes
  defp find_factors(number, divisor, primes) do
    case rem(number, divisor) do
      0 -> find_factors(div(number, divisor), divisor, [divisor | primes])
      _ -> find_factors(number, divisor + 1, primes)
    end
  end
end
