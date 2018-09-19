defmodule Live.Counter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{count: 0}}
  end

  def inc do
    GenServer.call(__MODULE__, :inc)
  end

  def dec do
    GenServer.call(__MODULE__, :dec)
  end

  def get_count do
    GenServer.call(__MODULE__, :get_count)
  end

  def handle_call(:inc, _from, state) do
    {:reply, :ok, %{count: state.count + 1}}
  end

  def handle_call(:dec, _from, state) do
    {:reply, :ok, %{count: state.count - 1}}
  end

  def handle_call(:get_count, _from, state) do
    {:reply, state.count, state}
  end
end
