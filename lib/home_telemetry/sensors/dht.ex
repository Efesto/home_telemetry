defmodule HomeTelemetry.Sensors.DHT do
  @moduledoc """
  Humidity and temperature sensor
  """

  @dht_port 17

  def start_polling(interval, type) do
    DHT.start_polling(@dht_port, type, interval)
  end
end
