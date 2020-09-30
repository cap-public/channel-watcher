defmodule ChannelWatcherTest do
  use ExUnit.Case, async: true
  doctest ChannelWatcher

  test "callback on text" do
    pid = spawn(fn -> Process.sleep(30) end)
    :ok = ChannelWatcher.monitor(pid, {__MODULE__, :confirm, [self(), "confirmed"]})
    assert_receive {:ok, "confirmed"}
  end

  test "demonitoring prevents callback" do
    pid = spawn(fn -> Process.sleep(30) end)
    :ok = ChannelWatcher.monitor(pid, {__MODULE__, :confirm, [self(), "confirmed"]})
    :ok = ChannelWatcher.demonitor(pid)
    refute_receive {:ok, "confirmed"}
  end

  test "demonitoring non-existant PID errors" do
    :error = ChannelWatcher.demonitor(nil)
  end

  test "trying to monitor something that isn't a PID errors" do
    invalid_pid = spawn(fn -> :ok end)

    :error = ChannelWatcher.monitor(invalid_pid, {__MODULE__, :confirm, [self(), "confirmed"]})
    :error = ChannelWatcher.monitor(false, {__MODULE__, :confirm, [self(), "confirmed"]})
  end

  def confirm(pid, msg) do
    send(pid, {:ok, msg})
  end
end
