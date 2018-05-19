defmodule AcmeWorkdayManager.MixProject do
  use Mix.Project

  def project do
    [
      app: :acme_workday_manager,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"}
    ]
  end
end
