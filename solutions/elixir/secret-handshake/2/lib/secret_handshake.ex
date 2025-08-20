defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    <<a,b,c,d,e>> = Integer.to_string(code,2) |> String.pad_leading(5, "0") |> String.slice(-5..-1)
    []
    |> plus(e,"wink")
    |> plus(d, "double blink")
    |> plus(c, "close your eyes")
    |> plus(b, "jump")
    |> mod(a, &Enum.reverse/1)
  end

  defp plus(acc, decider, str) do
    mod(acc, decider, fn acc -> acc ++ [str] end)
  end

  defp mod(acc, ?1, fun), do: fun.(acc)
  defp mod(acc, _, fun), do: acc
end
