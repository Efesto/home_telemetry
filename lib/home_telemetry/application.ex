defmodule HomeTelemetry.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HomeTelemetry.Supervisor]

    children = children(target())

    HomeTelemetry.SensorEventHandler.attach()

    HomeTelemetry.Sensors.DHT22.start_polling()
    Ccs811.start_polling()

    Supervisor.start_link(children, opts)
  end

  def children(:target) do
    [
      HomeTelemetry.WifiStatusCheck,
      HomeTelemetry.SeriesConnection
    ]
  end

  def children(_target) do
    [
      HomeTelemetry.SeriesConnection
    ]
  end

  def target() do
    Application.get_env(:home_telemetry, :target)
  end
end
