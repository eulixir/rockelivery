defmodule Rockelivery.Stack do
  use GenServer

  # Client

  def start_link(initial_state) when is_list(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server (Callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  # sync
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  # sync
  def handle_call({:push, element}, _from, state) do
    {:reply, [element | state], [element | state]}
  end

  @impl true
  # async
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
