defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      String.ends_with?(String.trim(input), "?") and input == String.upcase(input) and Regex.match?(~r/\p{L}/, input) -> "Calm down, I know what I'm doing!"
      String.ends_with?(String.trim(input), "?") -> "Sure."
      input == String.upcase(input) and Regex.match?(~r/\p{L}/, input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
