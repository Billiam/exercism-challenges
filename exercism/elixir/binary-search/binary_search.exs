require IEx
defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search(list, key) do
    case list |> sorted? do
      true -> traverse(Enum.with_index(list), key)
      false -> raise ArgumentError, message: "expected list to be sorted"
    end
  end
  
  defp traverse([], _key), do: :not_found
  
  defp traverse(list, key) do
    {result, position} = Enum.at(list, div(length(list), 2))

    case result do
      ^key -> {:ok, position}
      n when n > key -> traverse(Enum.slice(list, 0..position - 1), key)
      _ -> traverse(Enum.slice(list, position + 1..-1), key)
    end
  end
  
  defp sorted?(list), do: Enum.sort(list) == list
end
