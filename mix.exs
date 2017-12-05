defmodule Stex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stex,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: "A lightweight client for the new SmartThings API",
      source_url: "https://github.com/jodyalbritton/stex",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: [
        maintainers: ["Jody Albritton"],
        licenses: ["Apache 2.0"],
        links: %{"GitHub" => "https://github.com/jodyalbritton/stex"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:apex, "~>1.2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
