defmodule TakeANumber do
  def start() do
    # Please implement the start/0 function
    spawn(fn -> TakeANumber.loop(0) end)
  end

  def loop(state) do
    receive do
      {:report_state, sender_pid} -> report_state(state, sender_pid)
      {:take_a_number, sender_pid} -> take_a_number(state, sender_pid)
      :stop -> nil
      _ -> loop(state)
    end
  end

  def report_state(state, sender_pid) do
    send(sender_pid, state)
    loop(state)
  end

  def take_a_number(state, sender_pid) do
    report_state(state+1, sender_pid)
  end
end
