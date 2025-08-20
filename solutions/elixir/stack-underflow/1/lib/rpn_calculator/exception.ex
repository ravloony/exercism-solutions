defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  # Please implement StackUnderflowError here.
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
