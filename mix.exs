defmodule DiscordEmbedValidator.MixProject do
  use Mix.Project

  def project do
    [
      app: :discord_embed_validator,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:skooma, "~> 0.2.0"},
      {:mix_test_watch, "~> 1.0", only: :test, runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
