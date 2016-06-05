defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> char_list
    |> char_count
    |> List.flatten() 
    |> Enum.join()
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> char_sets
    |> expand_list
    |> Enum.join()
  end
  
  defp char_sets(string) do
    Regex.scan(~r/(\d+)(\D+)/, string) |> Enum.map(&Enum.take(&1, -2))
  end
  
  defp char_list(string) do
    String.split(string, "", trim: true) 
  end
  
  defp char_count(char_list) do
    Enum.chunk_by(char_list, &(&1)) 
    |> Enum.map(&([length(&1), Enum.at(&1, 0)]))
  end
  
  defp expand_list(list) do
    Enum.map(list, &expand_set/1)
  end
  
  defp expand_set(set) do
    String.duplicate(Enum.at(set, 1), Enum.at(set, 0) |> String.to_integer())
  end
end
