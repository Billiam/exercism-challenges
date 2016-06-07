defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> tokens
    |> Enum.reduce([], &select_stack_action/2)
    |> verify_brackets
  end
  
  # Create a flat list of only opening and closing brackets
  defp tokens(str) do
    Regex.scan(~r/[\p{Ps}\p{Pe}]/, str) |> Enum.concat
  end
  
  # Opening brackets should be added to the stack,
  # Closing brackets should remove the correct opening bracket from the stack
  defp select_stack_action(char, acc) do
    cond do
       Regex.match?(~r/\p{Ps}/, char) -> push(char, acc)
       true -> pop(char, acc)
    end
  end
  
  # Remove associated opening bracket from the stack
  defp pop(")", ["(" | tail]), do: tail
  defp pop("}", ["{" | tail]), do: tail
  defp pop("]", ["[" | tail]), do: tail
  
  # Closing bracket is incorrect for the stack, return an unpoppable atom
  defp pop(_, acc), do: :invalid
  
  # Add an opening brace to the stack
  defp push(char, acc) do
    [char | acc]
  end  
    
  # An empty stack means valid opening and closing bracket pairs
  # Anything else means missing closing brackets, or an invalid closing bracket at some point
  defp verify_brackets([]), do: true
  defp verify_brackets(_), do: false
end
