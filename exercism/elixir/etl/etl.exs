defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input |> Enum.reduce(%{}, &iterate_names/2)
  end
  
  defp iterate_names({key, names}, acc) do
    names 
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(acc, fn name, acc -> Map.put(acc, name, key) end)
  end
  
end
