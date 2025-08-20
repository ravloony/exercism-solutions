defmodule NameBadge do
  def print(id, name, department) do
    idstr = if id == nil, do: "", else: "[#{id}] - "
    depstr = if department == nil, do: "OWNER", else: String.upcase(department)
    "#{idstr}#{name} - #{depstr}"
  end
end
