defmodule AfricastalkingElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :africastalking_elixir,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
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
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.4"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Maurice Kusasirwa"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/capdiz/africastalking_elixir"}
    ]
  end

  defp description do
    """
    Unofficial AfricasTalking elixir library to work with the AfricasTalking telco api. Currently covering sending SMS
    """
  end
end
