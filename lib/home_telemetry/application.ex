defmodule HomeTelemetry.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias HomeTelemetry.Sensors.DHT

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HomeTelemetry.Supervisor]

    children = children(target())

    HomeTelemetry.SensorEventHandler.attach()

    dht_interval = Application.get_env(:home_telemetry, :dht_interval_seconds)
    dht_type = Application.get_env(:home_telemetry, :dht_type)

    DHT.start_polling(dht_interval, dht_type)
    Ccs811.start_polling()

    Supervisor.start_link(children, opts)
  end

  def children(_target) do
    [
      HomeTelemetry.NetStatusCheck,
      HomeTelemetry.SeriesConnection
    ]
  end

  def target() do
    Application.get_env(:home_telemetry, :target)
  end
end
