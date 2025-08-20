defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
      |> String.replace(~r/[^A-Za-z0-9\s-]/u, "")
      |> String.split(~r/( |-)/, trim: true) 
      |> List.foldl("", fn el, acc -> "#{acc}#{el |> String.at(0) |> String.upcase()}" end)
  end
end
