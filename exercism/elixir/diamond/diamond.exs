defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(char) do
    range = ?A .. char |> Enum.to_list
    
    diamond = range
    |> Enum.with_index
    |> Enum.map(fn {letter, index} ->
      char_line(letter, index, length(range))
    end)
    |> mirror
    |> Enum.join("\n")
    
    diamond <> "\n"
  end
  
  defp char_line(letter, line_number, max_width) do
    left_pad = String.duplicate(" ",  max_width - 1 - line_number)
    right_pad = String.duplicate(" ", line_number)
      
    left_pad <> to_string([letter]) <> right_pad |> mirror
  end
  
  defp mirror(str) when is_binary (str) do
    str <> (String.reverse(str) |> String.slice(1 .. -1))
  end
  
  defp mirror(list) when is_list(list) do
    list ++ (Enum.reverse(list) |> Enum.slice(1 .. -1))
  end
end
