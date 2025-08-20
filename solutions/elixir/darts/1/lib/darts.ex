defmodule Darts do
  @type position :: {number, number}

  def diagonal(x, y) do
    :math.sqrt((:math.pow(x, 2) + :math.pow(y, 2)))
  end

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    diag = Darts.diagonal(x, y)
    cond do
      diag > 10.0 -> 0
      diag > 5.0 -> 1
      diag > 1.0 -> 5
      true -> 10
    end
  end
end
