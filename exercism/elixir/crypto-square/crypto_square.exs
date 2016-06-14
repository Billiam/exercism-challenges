defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) do
    str 
    |> normalize 
    |> to_rect
    |> transpose
    |> join
  end
  
  defp normalize(str) do
    str |> String.downcase |> String.replace(~r/[^0-9a-z]+/, "")
  end
  
  defp to_rect(str) do
    row_count = str |> String.length |> :math.sqrt |> Float.ceil |> trunc
    
    to_rows(str, row_count)
  end
  
  defp to_rows(_, 0), do: []
  defp to_rows(str, count) do
    str |> String.split("", trim: true) |> Enum.chunk(count, count, Stream.cycle([""]))
  end
  
  defp transpose(list_of_lists) do
    List.zip(list_of_lists)
    |> Enum.map(&Tuple.to_list/1)
  end
  
  defp join(list_of_lists) do
    list_of_lists
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join(" ")
  end
end
