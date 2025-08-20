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

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | tail]), do: true
  def has_day_without_birds?([head | tail]) do
    false || has_day_without_birds?(tail)
  end

  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5, do: busy_days(tail) + 1
  def busy_days([head | tail]), do: busy_days(tail)

end
