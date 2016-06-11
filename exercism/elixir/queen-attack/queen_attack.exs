defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  def new(), do: new({0,3}, {7, 3})
  
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white, black) when white == black, do: raise ArgumentError
  def new(white, black) do
    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board(queens)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  defp board(queens) do
    Enum.map(0..7, &(row(&1, queens)))
  end
  
  defp row(x, queens) do
    Enum.map(0..7, fn y -> 
      square({x, y}, queens)
    end)
  end
  
  defp square(coordinate, %Queens{white: white}) when coordinate == white, do: 'W'
  defp square(coordinate, %Queens{black: black}) when coordinate == black, do: 'B'
  defp square(_, _), do: '_'

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{ white: {x1, y1}, black: {x2, y2} }) do
    cond do
      x1 == x2 -> true
      y1 == y2 -> true
      abs(x1 - x2) == abs(y1 - y2) -> true
      true -> false
    end
  end
end
