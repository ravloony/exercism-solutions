defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}
        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end

  end
  
  def divide(list) do
    case list do
      [] ->
        raise StackUnderflowError, "when dividing"
      [_] ->
        raise StackUnderflowError, "when dividing"
      [0 | _] ->
        raise DivisionByZeroError
      [a | [b]] ->
        div(b, a)
    end
  end
end
