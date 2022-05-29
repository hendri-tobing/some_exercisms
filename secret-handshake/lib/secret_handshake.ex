defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @list_of_commands [
    "wink",
    "double blink",
    "close your eyes",
    "jump"
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code == 0, do: []
  def commands(code) when code == 1, do: ["wink"]
  def commands(code) when code == 10, do: ["double blink"]
  def commands(code) when code == 100, do: ["close your eyes"]
  def commands(code) when code == 1000, do: ["jump"]

  def commands(code) do
    list = code |> convert_dec_to_bin_list()
    convert_to_command(list, length(list)) |> Enum.reverse()
  end

  defp convert_to_command(list, length) when length == 0 or length > 5 or list == [], do: []
  defp convert_to_command(list, length) when length == 5 do
    [_head | tail] = list
    convert_to_command(tail, (length - 1)) |> Enum.reverse()
  end

  defp convert_to_command(list, length) do
    [head | tail] = list
    if head == "1" do
      [(@list_of_commands |> Enum.at(length - 1))] ++ convert_to_command(tail, length - 1)
    else
      convert_to_command(tail, length - 1)
    end
  end

  defp convert_dec_to_bin_list(integer) do
    integer
    |> dec_to_bin_list()
    |> Enum.reverse()
    |> Enum.map(&
        &1 |> Integer.to_string)
  end

  defp dec_to_bin_list(integer) when integer == 1, do: [1]

  defp dec_to_bin_list(integer) do
    if rem(integer, 2) == 0 do
      [0] ++ (integer |> div(2) |> dec_to_bin_list())
    else
      [1] ++ (integer |> div(2) |> dec_to_bin_list())
    end
  end
end
