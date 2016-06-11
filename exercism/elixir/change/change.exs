defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    divide(amount, values) |> validate
  end
  
  defp divide(amount, coins) do
    coins |> denomination_sorted |> Enum.reduce({ amount, %{} }, &change_in_coin/2)
  end
    
  defp denomination_sorted(coins) do
    coins |> Enum.sort |> Enum.reverse
  end
  
  defp change_in_coin(coin, { change, result}) do
    { coin_count, remainder } = divmod(change, coin)
    
    {remainder, Map.put(result, coin, coin_count)}
  end

  defp validate({0, change}), do: {:ok, change}
  defp validate(_), do: :error
  
  defp divmod(dividend, divisor) do
    {div(dividend, divisor), rem(dividend, divisor)}
  end
end
