defmodule HomeTelemetry.Sensors.DHT22 do
  @moduledoc """
  Humidity and temperature sensor
  """

  @dht22_port 17

  def start_polling(interval) do
    DHT.start_polling(@dht22_port, :dht22, interval)
  end
end
