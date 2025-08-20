defmodule BirdCount do
  def today([]), do: nil
  def today([head | tail]) do
    # Please implement the today/1 function
    head
  end

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]) do
    # Please implement the increment_day_count/1 function
    [head + 1 | tail]
  end

  def has_day_without_birds?(list) do
    # Please implement the has_day_without_birds?/1 function
    list |> Enum.reduce(false, fn (x, acc) -> acc || x == 0 end)
  end

  def total(list) do
    # Please implement the total/1 function
    list |> Enum.reduce(0, fn (x, acc) -> acc + x end)
  end

  def busy_days(list) do
    # Please implement the busy_days/1 function
    list
      |> Enum.filter(fn x -> x >= 5 end)
      |> Enum.count()
  end
end
