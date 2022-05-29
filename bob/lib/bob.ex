defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) when is_nil(input) or input == "", do: "Fine. Be that way!"

  def hey(input) do
    input = String.trim(input)

    cond do
      is_nothing?(input) -> "Fine. Be that way!"
      is_yell_question?(input) -> "Calm down, I know what I'm doing!"
      is_yell?(input) -> "Whoa, chill out!"
      is_question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp is_nothing?(input), do: input == ""
  defp is_question?(input), do: input |> String.ends_with?("?")

  defp is_yell?(input),
    do:
      input == String.upcase(input) && input != String.downcase(input) &&
        !(input |> String.ends_with?("?"))

  defp is_yell_question?(input),
    do:
      input == String.upcase(input) && input != String.downcase(input) &&
        input |> String.ends_with?("?")
end
