defmodule Username do
  def sanitize(''), do: ''
  def sanitize([head | tail]) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    case head do
      head when (head >= ?a and head <= ?z or head == ?_) -> [head] ++ sanitize(tail)
      head when head == ?ä -> [?a, ?e] ++ sanitize(tail)
      head when head == ?ö -> [?o, ?e] ++ sanitize(tail)
      head when head == ?ü -> [?u, ?e] ++ sanitize(tail)
      head when head == ?ß -> [?s, ?s] ++ sanitize(tail)
      _ -> sanitize(tail)
    end
  end
end
