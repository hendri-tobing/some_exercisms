defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{format_bottle(number) |> String.capitalize()} of beer on the wall, #{format_bottle(number)} of beer.
    #{take(number)}, #{format_bottle(number - 1)} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(_first..last = range) do
    range
    |> Enum.reduce(
      "",
      fn x, acc -> acc <> verse(x) <> new_line?(x, last) end
    )
  end

  @spec lyrics() :: String.t()
  def lyrics() do
    lyrics(99..0)
  end

  defp format_bottle(number) when number == 0, do: "no more bottles"
  defp format_bottle(number) when number == 1, do: "1 bottle"
  defp format_bottle(number) when number == -1, do: "99 bottles"
  defp format_bottle(number), do: "#{number} bottles"

  defp take(number) when number == 0, do: "Go to the store and buy some more"
  defp take(number) when number == 1, do: "Take it down and pass it around"
  defp take(_number), do: "Take one down and pass it around"

  defp new_line?(x, last_number) when x == last_number, do: ""
  defp new_line?(_x, _last_number), do: "\n"
end
