defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    @planetary_classes |> Enum.random()
  end

  def random_ship_registry_number() do
    "NCC-" <> to_string(:rand.uniform(8999) + 1000)
  end

  def random_stardate() do
    :rand.uniform() * 1000 + 41000
  end

  @spec format_stardate(float) :: string
  def format_stardate(stardate) when is_float(stardate) do
    stardate
      |> Float.round(1)
      |> to_string()
  end
  def format_stardate(stardate), do: raise ArgumentError
end
