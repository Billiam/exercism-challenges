defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, search) when search in @nucleotides do
    strand
    |> validate_strand
    |> Enum.count(&(&1 === search))
  end
  def count(_invalid_nucleotide, _), do: raise ArgumentError
  
  # Map individual nucleotides to use pattern matching for validation.
  defp validate_strand(strand) do
    Enum.map(strand, &validate_nucleotide/1)
  end
  
  defp validate_nucleotide(nucleotide) when nucleotide in @nucleotides do
    nucleotide
  end
  defp validate_nucleotide(_), do: raise ArgumentError
  
  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
   usage = strand
    |> validate_strand
    |> Enum.group_by(&(&1))
    |> Enum.into(%{}, fn{k,v} -> {k, length(v)} end)
    
    Map.merge(default_histogram, usage)
  end
  
  defp default_histogram do
    Enum.into(@nucleotides, %{}, &({&1, 0}))
  end
end
