defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
   nbase = normalize(base)
   lbase = String.length(base)
   dbase = String.downcase(base)
   candidates
      |> Enum.filter(fn(x) -> String.length(x) === lbase end)
      |> Enum.filter(fn(x) -> String.downcase(x) !== dbase end)
      |> Enum.filter(fn(x) -> normalize(x) === nbase end)
  end

  defp normalize(s) do
    s
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
