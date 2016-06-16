defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> normalize
    |> to_char_list
    |> Enum.map(&encode_char/1)
    |> obfuscate
    |> to_string
  end
  
  defp normalize(string) do
    string
    |> String.downcase
    |> String.replace(~r/\W/, "")
  end
  
  defp encode_char(char) when char > 96 and char < 124 do
    abs(char - 123) + 96
  end
  defp encode_char(char), do: char
  
  defp obfuscate(charlist) do
    charlist
    |> Enum.chunk(5, 5, [])
    |> Enum.map(&to_string/1)
    |> Enum.join(" ")
  end
end
