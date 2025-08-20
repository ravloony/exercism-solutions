defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, &(&1[:price] <= &2[:price]))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1[:price] == nil))
  end

  def increase_quantity(item, count) do
    %{item | quantity_by_size: Enum.map(item[:quantity_by_size], fn {k, v} -> {k, v+count} end ) |> Enum.into(%{})}
  end

  def total_quantity(item) do
    Enum.reduce(item[:quantity_by_size], 0, fn {_k,v}, acc -> acc+v end)
  end
end
