defmodule HomeTelemetry.ReadHandler do
  require Logger

  def handle_read([:dht, :read], %{temperature: temp, humidity: humidity}, _metadata, _config) do
    Logger.info("Temperature: #{temp} C")
    Logger.info("Humidity: #{humidity} %")
  end
end
