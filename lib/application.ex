defmodule ChannelWatcher.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      ChannelWatcher
    ]

    opts = [strategy: :one_for_one, name: ChannelWatcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
