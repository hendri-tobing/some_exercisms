defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) when length(list) == 0, do: []
  def flatten(list) do
    [head | tail] = list
    case head do
      head when is_nil(head) ->
        flatten(tail)
      head when is_list(head) ->
        flatten(head) ++ flatten(tail)
      head when is_integer(head) ->
        [head | flatten(tail)]
      _ -> flatten(tail)
    end
  end
end
