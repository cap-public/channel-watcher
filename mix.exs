defmodule ChannelWatcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :channel_watcher,
      source_url: "https://gitlab.com/cap-public/packages/channel-watcher/",
      homepage_url: "https://gitlab.com/cap-public/packages/channel-watcher/",
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.html": :test],
      docs: [
        main: "readme", # The main page in the docs
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ChannelWatcher.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.13.2", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
    ]
  end

  defp description do
    "A GenServer to monitor PIDs and run callbacks they go down."
  end

  defp package do
    [
      licenses: ["CC-BY-SA-4.0"],
      links: %{"GitLab" => "https://gitlab.com/cap-public/packages/channel-watcher/"},
    ]
  end
end
