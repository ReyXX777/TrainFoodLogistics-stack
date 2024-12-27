defmodule TrainFoodDelivery.MixProject do
  use Mix.Project

  def project do
    [
      app: :train_food_delivery,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: {TrainFoodDelivery.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :redix,        # Redis support
        :swoosh        # Email support
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Returns the list of dependencies for the project.
  defp deps do
    [
      {:phoenix, "~> 1.5.9"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},                   # PostgreSQL driver
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_view, "~> 0.15.0"},
      {:floki, ">= 0.30.0", only: :test},        # HTML parsing in tests
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev}, # Asset bundling
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 0.5"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},                        # JSON parsing
      {:plug_cowboy, "~> 2.5"},                 # Web server
      {:redix, ">= 0.0.0"},                     # Redis for caching
      {:swoosh, "~> 1.3"},                      # Email service
      {:phoenix_swoosh, "~> 0.3"},              # Phoenix integration for Swoosh
      {:twilio, "~> 0.1.2"},                    # Twilio for SMS
      {:distillery, "~> 2.1", runtime: false},  # Deployment and releases
      {:ex_machina, "~> 2.7", only: :test},     # Test data factories
      {:mock, "~> 0.3.5", only: :test},         # Mocking for tests
      {:ecto_psql_extras, "~> 0.6"},            # PostgreSQL introspection tools
      {:phoenix_pubsub, "~> 2.0"},              # PubSub for real-time features
      {:cowboy, "~> 2.8"}                       # HTTP server
    ]
  end

  # Aliases are shortcuts or tasks specific to the project.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
