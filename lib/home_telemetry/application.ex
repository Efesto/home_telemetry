defmodule HomeTelemetry.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias HomeTelemetry.Sensors.DHT22

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HomeTelemetry.Supervisor]

    children = children(target())

    HomeTelemetry.SensorEventHandler.attach()

    dht22_interval = Application.get_env(:home_telemetry, :dht22_interval_seconds)

    DHT22.start_polling(dht22_interval)
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
