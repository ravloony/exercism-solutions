defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    cond do
      length(strand1) !== length(strand2) -> {:error, "strands must be of equal length"}
      true -> {:ok, 
                Enum.zip_reduce(
                  [strand1, strand2],
                  0,
                  fn elements, acc -> acc + (elements |> IO.inspect() |> Enum.reduce(fn first, second -> ((first === second) && 0 || 1) |> IO.inspect() end)) end
                )
              }
    end
  end
end
