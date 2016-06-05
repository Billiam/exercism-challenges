defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn(_, count) -> count + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], &([&1 | &2]))
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    reverse(l)
    |> reduce([], &[f.(&1) | &2 ])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce(l, [], fn(item, acc) -> 
      case f.(item) do
        true -> [item | acc]
        false -> acc
      end
    end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([head|tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end
  
  def reduce([], acc, f), do: acc

  @spec append(list, list) :: list
  def append(a, b) do
    reverse(a)
    |> reduce(b, &([&1 | &2]))
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reverse(ll) 
    |> reduce([], &append/2)
  end
end
