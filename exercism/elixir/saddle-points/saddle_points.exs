defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str), do: parse(str)

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str |> rows |> transpose
  end
  
  defp parse(str) do
    str 
    |> String.split("\n")
    |> Enum.map(fn row -> 
      String.split(row, " ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp transpose(list_of_lists) do
    List.zip(list_of_lists)
    |> Enum.map(&Tuple.to_list/1)
  end
  
  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    row_list = max_rows(str) |> Enum.with_index
    column_list = min_columns(str) |> Enum.with_index
    
    for {max_num, row} <- row_list, {min_num, column} <- column_list, max_num == min_num do
      { row, column }
    end
  end
  
  defp min_columns(str) do
    str |> columns |> Enum.map(&Enum.min/1)
  end
  
  defp max_rows(str) do
    str |> rows |> Enum.map(&Enum.max/1)
  end
end
