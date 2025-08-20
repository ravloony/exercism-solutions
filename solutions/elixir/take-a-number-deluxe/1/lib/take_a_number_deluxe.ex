defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl true
  def init(init_args) do
    min_number = Keyword.get(init_args, :min_number)
    max_number = Keyword.get(init_args, :max_number)
    auto_shutdown_timeout = Keyword.get(init_args, :auto_shutdown_timeout, :infinity)
    case __MODULE__.State.new(min_number, max_number, auto_shutdown_timeout) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, reason} -> {:stop, reason}
    end
  end

  @impl true
  def handle_call(message, _, state) do
    case message do
      :report_state -> {:reply, state, state, state.auto_shutdown_timeout}
      :queue_new_number -> case TakeANumberDeluxe.State.queue_new_number(state) do
        {:ok, new_number, new_state} -> {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}
        {:error, error} -> {:reply, {:error, error}, state, state.auto_shutdown_timeout}
      end
      {:serve_next_queued_number, priority_number} -> case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
        {:ok, next_number, new_state} -> {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}
        {:error, error} -> {:reply, {:error, error}, state, state.auto_shutdown_timeout}
      end
      _ -> {:error, "not implemented"}
    end
  end

  @impl true
  def handle_cast(message, state) do
    case message do
      :reset_state -> case TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout) do
        {:ok, new_state} -> {:noreply, new_state, state.auto_shutdown_timeout}
        {:error, error} -> {:noreply, state, state.auto_shutdown_timeout}
      end
    end
  end

  @impl true
  def handle_info(msg, state) do
    case msg do
      :timeout -> {:stop, :normal, state}
      _ -> {:noreply, state, state.auto_shutdown_timeout}
    end
  end
end
