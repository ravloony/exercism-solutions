defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    ldigits = Enum.count(digits)
    res = digits
      |> Enum.reduce(0, fn(x, acc) -> acc + Integer.pow(x, ldigits) end)
    res === number
  end
end
