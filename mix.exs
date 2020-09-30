defmodule ChannelWatcher.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://gitlab.com/cap-public/packages/channel-watcher/"

  def project do
    [
      app: :channel_watcher,
      source_url: @source_url,
      homepage_url: @source_url,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.html": :test],
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ChannelWatcher.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.13.2", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp description do
    """
    A GenServer to monitor PIDs and run callbacks they go down - originally
    designed to be a watcher for Phoenix channels.
    """
  end

  defp package do
    [
      licenses: ["CC-BY-SA-4.0"],
      links: %{"GitLab" => @source_url}
    ]
  end
end
