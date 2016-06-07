defmodule DNA do
  @rna %{ ?A => ?U, ?C =>  ?G, ?T =>  ?A, ?G =>  ?C }
  @translatable Map.keys(@rna)
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &translate/1)
  end

  def translate(nucleotide) when nucleotide in @translatable do
    Map.get(@rna, nucleotide)
  end
  def translate(_), do: raise ArgumentError, message: "Invalid nucleotide in sequence"
end
