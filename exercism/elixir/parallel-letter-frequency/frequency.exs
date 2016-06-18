defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    texts
    |> process(workers)
    |> collect
  end
  
  defp process(texts, workers) do
    master = self()
    chunk_size = length(texts) / workers |> Float.ceil |> trunc
    
    texts
    |> Enum.chunk(chunk_size)
    |> Enum.map(&spawn(&1, master))
  end
  
  defp collect(pids) do
    pids
    |> Enum.map(fn _ ->
      receive do
        msg -> msg
      end
    end)
    |> Enum.concat
    |> Enum.reduce(%{}, fn res, acc -> 
      Map.merge(acc, res, fn(_k, v1, v2) ->
        v1 + v2
      end)
    end)
  end
  
  defp spawn(texts, master) do
    spawn(fn ->
      map = texts
      |> Enum.map(&process_text/1)
      
      send(master, map)
    end)
  end
  
  defp process_text(text) do
    text
    |> String.downcase
    |> String.replace(~r/[^\p{L}]+/u, "")
    |> String.graphemes
    |> Enum.group_by(&(&1))
    |> Enum.into(%{}, fn {char, usage} -> {char, length(usage)} end)
  end
end
