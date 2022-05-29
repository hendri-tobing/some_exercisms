defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> reverse_num_to_charlist()
    |> convert_to_roman(0, "")
  end

  defp reverse_num_to_charlist(number), do: number |> to_charlist() |> Enum.reverse()

  defp codepoint_to_string(codepoint), do: <<codepoint::utf8>>

  defp convert_to_roman(number_list, _position, roman) when number_list |> length == 0, do: roman

  defp convert_to_roman(number_list, position, roman) do
    [head | tail] = number_list

    new_roman =
      head
      |> codepoint_to_string()
      |> formula_template(position)
      |> Kernel.<>(roman)

    convert_to_roman(tail, position + 1, new_roman)
  end

  defp formula_template(number, position) do
    value = map_position(position)

    case number do
      "1" -> value
      "2" -> value <> value
      "3" -> value <> value <> value
      "4" -> value <> mid(value)
      "5" -> mid(value)
      "6" -> mid(value) <> value
      "7" -> mid(value) <> value <> value
      "8" -> mid(value) <> value <> value <> value
      "9" -> value <> (value |> mid() |> mid)
      _ -> ""
    end
  end

  defp map_position(position) do
    case position do
      0 -> "I"
      1 -> "X"
      2 -> "C"
      3 -> "M"
      _ -> ""
    end
  end

  defp mid(l) do
    case l do
      "I" -> "V"
      "V" -> "X"
      "X" -> "L"
      "L" -> "C"
      "C" -> "D"
      "D" -> "M"
      _ -> ""
    end
  end
end
