defmodule Phone do
  defp normalize(raw) do
    raw |> parse |> cleanup |> validate
  end

  defp parse(raw) do
    String.split(raw, "") |> Enum.reduce([], &parse_char/2) 
  end

  defp parse_char(_, :invalid), do: :invalid
  defp parse_char(char, acc) do
    cond do
      Regex.match?(~r/\p{N}/u, char) -> [char | acc]
      Regex.match?(~r/\p{L}/u, char) -> :invalid
      true -> acc
    end
  end
  
  defp cleanup(:invalid), do: :invalid
  defp cleanup(list) do
    list = Enum.reverse(list)
    
    cond do
      length(list) === 11 and List.first(list) === "1" -> Enum.drop(list, 1)
      length(list) === 10 -> list
      true -> :invalid
    end
  end
  
  defp validate(:invalid), do: List.duplicate("0", 10)
  defp validate(list), do: list
  
  defp format_plain(list), do: Enum.join(list)

  defp area(list) do
    list |> Enum.take(3) |> format_plain
  end
  
  defp prefix(list) do
    list |> Enum.slice(3..5) |> format_plain
  end
  
  defp suffix(list) do 
    list |> Enum.take(-4) |> format_plain
  end
  
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw |> normalize |> format_plain
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw |> normalize |> area
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    number = raw |> normalize
    
    "(#{area(number)}) #{prefix(number)}-#{suffix(number)}"
  end
end
