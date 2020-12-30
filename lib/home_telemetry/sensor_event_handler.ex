defmodule HomeTelemetry.SensorEventHandler do
  alias HomeTelemetry.Series.DHT22

  require Logger

  def handle_event([:dht, :read], %{temperature: temp, humidity: humidity}, _metadata, _config) do
    Logger.info("Temperature: #{temp} C")
    Logger.info("Humidity: #{humidity} %")

    data = %DHT22{}

    HomeTelemetry.SeriesConnection.write(%{
      data
      | fields: %{data.fields | temperature: temp, humidity: humidity}
    })
  end

  def attach do
    :telemetry.attach(
      "dht_reader",
      [:dht, :read],
      &HomeTelemetry.SensorEventHandler.handle_event/4,
      nil
    )
  end
end
