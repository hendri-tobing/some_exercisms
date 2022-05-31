defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    case get_coins(coins, target) do
      nil -> {:error, "cannot change"}
      list_coins -> {:ok, list_coins}
    end
  end

  defp get_coins(coins, target) do
    coins
    |> get_coin_set(target, %{0 => []})
    |> Map.get(target)
  end

  defp get_coin_set(_coins, target, acc) when target <= 0, do: acc

  defp get_coin_set(coins, target, acc) do
    case Map.get(acc, target) do
      nil ->
        Enum.reduce(coins, acc, fn coin, acc ->
          new_target = target - coin
          acc = get_coin_set(coins, new_target, acc)

          if is_nil(acc[new_target]), do: acc, else: update_acc(target, coin, acc)
        end)

      _value ->
        acc
    end
  end

  defp update_acc(target, coin, acc) do
    updated_acc = [coin] ++ acc[target - coin]

    acc
    |> Map.update(
      target,
      updated_acc,
      &if(length(updated_acc) < length(&1), do: updated_acc, else: &1)
    )
  end
end
