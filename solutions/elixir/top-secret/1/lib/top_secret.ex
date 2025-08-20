defmodule TopSecret do
  def to_ast(string) do
    {_, ast} = string |> Code.string_to_quoted
    ast
  end
  
  def grab_name([{name, _, args}, _]) do
    case args do
      nil -> ""
      _ -> Atom.to_string(name) |> String.slice(0, length(args))
    end
  end

  def parse_def(ast, arglist, acc) do
    [{at, _, innerlist}, _] = arglist
    case at do
      :when -> parse_def(ast, innerlist, acc)
      _ -> {ast, [grab_name(arglist)] ++ acc}
    end
  end

  def decode_secret_message_part(ast, acc) 
  do
    case ast do
     {_, _, nil} -> {ast, acc}
     {:def, _, arglist} -> parse_def(ast, arglist, acc)
     {:defp, _, arglist} -> parse_def(ast, arglist, acc)
     _ -> {ast, acc}
    end
  end

  def decode_secret_message(string) do
    to_ast(string)
      |> Macro.prewalk([], &decode_secret_message_part/2)
      |> then(fn {ast, acc} -> acc end)
      |> Enum.reverse
      |> Enum.join
  end
end
