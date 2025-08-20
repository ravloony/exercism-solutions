defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      _ -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> 32
    end
  end

  def encode(list), do: do_encode(list, "")

  defp do_encode([], acc), do: acc
  defp do_encode([head | tail], acc), do: do_encode(tail, <<acc::bitstring, encode_nucleotide(head)::size(4)>>)

  def decode(dna), do: do_decode(dna, '')

  defp do_decode("", acc), do: acc
  defp do_decode(<<value::4, rest::bitstring>> = dna, acc), do: do_decode(rest, acc ++ [decode_nucleotide(value)])
end
