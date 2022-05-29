defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence 
    |> String.split([" ", "\n", ",", "_", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", ":", "."]) 
    |> Enum.map(&(&1 |> String.downcase)) 
    |> Enum.map(&(&1 |> String.trim_leading("'")))
    |> Enum.map(&(&1 |> String.trim_trailing("'")))
    |> Enum.reject(&(&1 == "")) 
    |> Enum.frequencies
  end
end
