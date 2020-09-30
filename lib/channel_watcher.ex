defmodule ChannelWatcher do
  use GenServer

  ## Client API

  def monitor(pid, callback) do
    GenServer.call(process_name(), {:monitor, pid, callback})
  end

  def demonitor(pid) do
    GenServer.call(process_name(), {:demonitor, pid})
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: process_name())
  end

  ## Server API

  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{channels: %{}}}
  end

  def handle_call({:monitor, pid, callback}, _from, state) do
    {reply, state} = if check_and_link_pid(pid) do
      {:ok, put_channel(state, pid, callback)}
    else
      {:error, state}
    end

    {:reply, reply, state}
  end

  def handle_call({:demonitor, pid}, _from, state) do
    case Map.fetch(state.channels, pid) do
      {:ok, _callback} ->
        Process.unlink(pid)
        {:reply, :ok, drop_channel(state, pid)}

      :error ->
        {:reply, :error, state}
    end
  end

  def handle_info({:EXIT, pid, _reason}, state) do
    case Map.fetch(state.channels, pid) do
      {:ok, {mod, func, args}} ->
        Task.start_link(fn -> apply(mod, func, args) end)
        {:noreply, drop_channel(state, pid)}

      :error ->
        {:noreply, state}
    end
  end

  defp drop_channel(state, pid) do
    %{state | channels: Map.delete(state.channels, pid)}
  end

  defp put_channel(state, pid, callback) do
    %{state | channels: Map.put(state.channels, pid, callback)}
  end

  defp check_and_link_pid(pid) do
    pid && Process.alive?(pid) && Process.link(pid)
  end

  ## Helpers

  def process_name() do
    Application.get_env(:channel_watcher, :process_name)
  end
end
