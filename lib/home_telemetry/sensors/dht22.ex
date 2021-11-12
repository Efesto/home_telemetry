defmodule HomeTelemetry.Sensors.DHT22 do
  @dht22_port 17
  @reading_interval_seconds 60

  def start_polling() do
    DHT.start_polling(@dht22_port, :dht22, @reading_interval_seconds)
  end
end
