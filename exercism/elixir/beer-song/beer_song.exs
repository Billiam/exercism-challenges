defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    beer_count = number - 1
    
    "#{wall_population beer_count}\n#{action_phrase beer_count}\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics() :: String.t
  def lyrics(), do: lyrics(100..1)

  @spec lyrics(Range.t) :: String.t
  def lyrics(range) do
    range |> Enum.map(&(verse(&1))) |> Enum.join("\n")
  end
  
  defp wall_population(n) do
    "#{wall_description n}, #{available_beer n}" |> sentence
  end
  
  defp sentence(phrase) do
    "#{phrase}." |> String.capitalize
  end
  
  defp available_beer(n), do: "#{bottle_for n} of beer"
  
  defp wall_description(n), do: "#{available_beer n} on the wall"

  defp beer_reference(1), do: 'it'
  defp beer_reference(_n), do: 'one'
  
  defp action_phrase(n), do: action(n) |> sentence
  
  defp action(0), do: "Go to the store and buy some more, #{wall_description 99}"
  defp action(n), do: "Take #{beer_reference n} down and pass it around, #{wall_description n - 1}"
  
  defp plural_bottles(1), do: 'bottle'
  defp plural_bottles(_n), do: 'bottles'
    
  defp bottle_count(0), do: 'no more'
  defp bottle_count(n), do: n
  
  defp bottle_for(n), do: "#{bottle_count n} #{plural_bottles n}"
end
