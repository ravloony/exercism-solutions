defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
   Stream.iterate(2, &(&1 + 1)) 
   |> Stream.reject(&(not(is_prime(&1))))
   |> Stream.take(count)
   |> Stream.take(-1)
   |> Enum.into([])
   |> Enum.at(0)
  end

  defp is_prime(p) when p <= 3, do: true
  defp is_prime(p) when p > 3 do
    rem(p, 2) == 1 && Enum.reduce(2..(div(p, 2)), true, fn n, acc -> acc && not(rem(p, n) == 0) end)
  end
end
