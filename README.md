# ChannelWatcher

[![build status](https://gitlab.com/cap-public/packages/channel-watcher/badges/master/pipeline.svg)](https://gitlab.com/cap-public/packages/channel-watcher/-/commits/master) [![coverage report](https://gitlab.com/cap-public/packages/channel-watcher/badges/master/coverage.svg)](https://cap-public.gitlab.io/packages/channel-watcher/coverage/excoveralls.html)

A [GenServer](https://hexdocs.pm/elixir/GenServer.html) to monitor PIDs and run callbacks when they go down.

This is basically _slightly_ improved version of Chris McCord's answer to a [StackOverflow question](https://stackoverflow.com/a/33941469).

## Installation

The package can be installed by adding `channel_watcher` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:channel_watcher, git: "https://gitlab.com/cap-public/packages/channel-watcher", tag: "0.1"}
  ]
end
```

## Usage

Drop this in a module for a process you wish to test (such as a [Phoenix channel](https://hexdocs.pm/phoenix/channels.html)):

```elixir
:ok = ChannelWatcher.monitor(self(), {__MODULE__, CALLBACK, [ARGS]})
```

Make sure to replace `CALLBACK` with an atom of your callback function name, and `[ARGS]` with a list of arguments to pass to that callback.

The [test](test/channel_watcher_test.exs) also shows an example of usage.
