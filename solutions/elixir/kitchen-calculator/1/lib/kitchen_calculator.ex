defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    # Please implement the get_volume/1 function
    volume
  end

  def to_milliliter({unit, volume}) when unit == :milliliter, do: {:milliliter, volume}
  def to_milliliter({unit, volume}) when unit == :cup, do: {:milliliter, volume * 240}
  def to_milliliter({unit, volume}) when unit == :fluid_ounce, do: {:milliliter, volume * 30}
  def to_milliliter({unit, volume}) when unit == :teaspoon, do: {:milliliter, volume * 5}
  def to_milliliter({unit, volume}) when unit == :tablespoon, do: {:milliliter, volume * 15}

  def from_milliliter({_, volume}, unit) when unit == :milliliter, do: {unit, volume}
  def from_milliliter({_, volume}, unit) when unit == :cup, do: {unit, volume / 240}
  def from_milliliter({_, volume}, unit) when unit == :fluid_ounce, do: {unit, volume / 30}
  def from_milliliter({_, volume}, unit) when unit == :teaspoon, do: {unit, volume / 5}
  def from_milliliter({_, volume}, unit) when unit == :tablespoon, do: {unit, volume / 15}

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
