defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    if rem(number, 3) == 0 || rem(number, 5) == 0 || rem(number, 7) == 0 do
      check_prime_factor_3(number) <> check_prime_factor_5(number) <> check_prime_factor_7(number)
    else
      stringify(number)
    end
  end

  defp check_prime_factor_3(number) when rem(number, 3) == 0, do: "Pling"
  defp check_prime_factor_3(_number), do: ""

  defp check_prime_factor_5(number) when rem(number, 5) == 0, do: "Plang"
  defp check_prime_factor_5(_number), do: ""

  defp check_prime_factor_7(number) when rem(number, 7) == 0, do: "Plong"
  defp check_prime_factor_7(_number), do: ""

  defp stringify(number), do: number |> Integer.to_string()
end
