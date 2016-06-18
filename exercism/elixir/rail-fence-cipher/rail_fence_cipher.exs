defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    str
    |> String.graphemes
    |> to_rails(rails)
    |> Enum.join("")
  end
  
  defp to_rails(chars, rails) do
    chars
    |> Enum.with_index
    |> Enum.group_by(fn {_, i} ->
      offset = rails - 1
      (rem(i + offset, max(1, offset * 2)) - offset) |> abs
    end)
    |> Map.values
    |> Enum.map(fn chars -> 
      chars 
      |> Enum.reverse
      |> Enum.map(fn {char, _} -> char end)
    end)
    |> List.flatten
  end
  
  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do
    chars = str
    |> String.graphemes

    0..String.length(str) - 1
    |> to_rails(rails)
    |> Enum.with_index
    |> Enum.sort_by(fn {n, i} -> n end)
    |> Enum.map(fn {n, i} -> i end)
    |> Enum.map(&Enum.at(chars, &1))
    |> Enum.join("")
  end
end
