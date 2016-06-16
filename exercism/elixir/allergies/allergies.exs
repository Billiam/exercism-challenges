defmodule Allergies do
  use Bitwise
  
  @allergies ~w(
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  )
  
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    @allergies
    |> Enum.with_index
    |> Enum.filter_map(
        fn {_allergy, index} -> allergies_contain?(flags, index) end, 
        fn {allergy, _bit} -> allergy end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    list(flags) |> Enum.member?(item)
  end
  
  defp allergy_flag(item) do
    Map.get(@allergies, item, -1)
  end
  
  defp allergies_contain?(flags, index) do
    bit = 1 <<< index
    (bit &&& flags) == bit
  end
end
