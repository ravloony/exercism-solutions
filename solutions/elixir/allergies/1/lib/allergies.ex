defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
      flags |> Integer.to_string(2) |> IO.inspect() |> String.pad_leading(8, "0") |> String.slice(-8..-1) |> String.graphemes() |> Enum.with_index() |> IO.inspect() |> _list()
  end

  defp _list([]), do: []
  defp _list([{"0", _} | tail]), do: _list(tail)
  defp _list([{"1", 0} | tail]), do: ["cats"] ++ _list(tail)
  defp _list([{"1", 1} | tail]), do: ["pollen"] ++ _list(tail)
  defp _list([{"1", 2} | tail]), do: ["chocolate"] ++ _list(tail)
  defp _list([{"1", 3} | tail]), do: ["tomatoes"] ++ _list(tail)
  defp _list([{"1", 4} | tail]), do: ["strawberries"] ++ _list(tail)
  defp _list([{"1", 5} | tail]), do: ["shellfish"] ++ _list(tail)
  defp _list([{"1", 6} | tail]), do: ["peanuts"] ++ _list(tail)
  defp _list([{"1", 7} | tail]), do: ["eggs"] ++ _list(tail)
  defp _list([{"1", _} | tail]), do: _list(tail)

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    list(flags) |> MapSet.new() |> MapSet.member?(item)
  end
end
