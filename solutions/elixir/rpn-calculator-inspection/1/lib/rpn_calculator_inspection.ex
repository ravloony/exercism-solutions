defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> input |> calculator.() end)
    %{ input: input, pid: pid }
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal } -> Map.put(results, input, :ok )
      {:EXIT, ^pid, _ } -> Map.put(results, input, :error )
    after
      100 -> Map.put(results, input, :timeout )
    end
  end

  def reliability_check(calculator, inputs) do
    old = Process.flag(:trap_exit, true)
    results = inputs 
      |> Enum.map(fn input -> start_reliability_check(calculator, input) end) 
      |> Enum.reduce(%{}, fn output, acc ->
        await_reliability_check_result(output, acc)
      end)
    Process.flag(:trap_exit, old)
    results
  end

  def correctness_check(calculator, inputs) do
    inputs
      |> Enum.map(fn input -> Task.async(fn -> calculator.(input) end) end)
      |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
