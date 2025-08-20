# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {[], 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> elem(state, 0) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state -> 
      {plots, index}  = state
      plot = %Plot{plot_id: index, registered_to: register_to}
      {plot, {[plot | plots], index + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      {plots, index} = state
      {Enum.reject(plots, fn plot -> plot.plot_id == plot_id end), index}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      {plots, _index} = state
      Enum.find(plots, {:not_found, "plot is unregistered"}, fn plot -> plot.plot_id == plot_id end)
    end)
  end
end
