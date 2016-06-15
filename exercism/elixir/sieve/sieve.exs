defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    iterable_range = 2..div(limit, 2) |> Enum.to_list
     
    MapSet.difference(
      MapSet.new(2..limit),
      prime(iterable_range, limit, MapSet.new)
    ) 
    |> MapSet.to_list
    |> Enum.sort
  end
  
  defp prime([], _, sieve), do: sieve
  defp prime([h|tail], limit, sieve) do
    next_sieve = case MapSet.member?(sieve, h) do
      true -> sieve
      false ->
        max_range = div(limit, h)
        Enum.reduce(2..max_range, sieve, &(MapSet.put(&2, &1 * h)))
    end
    
    prime(tail, limit, next_sieve)
  end
end
