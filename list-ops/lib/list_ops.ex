defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) when l == [], do: 0
  def count(l) do
    [_head | tail] = l
    if is_list(tail) do
      1 + count(tail)
    else
      1
    end
  end

  @spec reverse(list) :: list
  def reverse(l) when l == [], do: []
  def reverse(l) do
    [head | tail] = l
    append(reverse(tail), [head])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, _f) when l == [], do: []
  def map(l, f) do
    [head | tail] = l
    [f.(head) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, _f) when l == [], do: []
  def filter(l, f) do
    [head | tail] = l
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, _f) when l == [], do: acc

  def foldl(l, acc, f) do
    [head | tail] = l
    foldl(tail, f.(head, acc), f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, _f) when l == [], do: acc
  def foldr(l, acc, f) do
    l
    |> reverse_list()
    |> foldl(acc, f)
  end

  @spec append(list, list) :: list
  def append(a, b) when a == [] and b == [], do: []
  def append(a, b) when a == [], do: b
  def append(a, b) when b == [], do: a

  def append(a, b) do
    [head | tail] = a
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) when ll == [], do: []
  def concat(ll) do
    [head | tail] = ll
    append(head, concat(tail))
  end

  defp reverse_list(list) when list == [], do: []
  defp reverse_list(list) do
    [head | tail] = list
    append(reverse_list(tail), [head])
  end
end
