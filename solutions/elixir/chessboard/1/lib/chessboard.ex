defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    rank_range |> range_list
  end

  def files do
    file_range |> range_list(&(List.to_string([&1])))
  end

  defp range_list(range, transform \\ &(&1)) do
    range |> Enum.map(transform)
  end
end
