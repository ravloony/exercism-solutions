defmodule AllYourBase do

  defp toten(list, _input_base) when length(list) == 1, do: Enum.at(list,0)
  defp toten([head | tail], input_base) do
    (input_base**(length(tail)) * head)  + toten(tail, input_base)
  end

  defp fromten(n, _output_base) when n == 0, do: []
  defp fromten(n, output_base) do
    d = div(n, output_base)
    r = rem(n, output_base)
    l = fromten(d, output_base)
    l ++ [r]
  end

  defp checkdigits(digits, input_base) do
    Enum.reduce(digits, true, fn x, acc -> acc && x >= 0 && x < input_base end)
  end

  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, _input_base, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_digits, input_base, _output_base) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert([head | _tail], input_base, _output_base) when head >= input_base or head < 0, do: {:error, "all digits must be >= 0 and < input base"}
  def convert([], _input_base, _output_base), do: {:ok, [0]}
  def convert([head|tail], input_base, output_base) when head ==0, do: convert(tail, input_base, output_base)
  def convert(digits, input_base, output_base) do
    if checkdigits(digits, input_base) do
      output_digits = digits
       |> toten(input_base)
       |> fromten(output_base)
      {:ok, output_digits }
    else
      {:error, "all digits must be >= 0 and < input base" }
    end
  end
end
