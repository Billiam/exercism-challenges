defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
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
