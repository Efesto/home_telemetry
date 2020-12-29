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

  @dht22_port 17
  @reading_interval 30

  def attach do
    DHT.start_polling(@dht22_port, :dht22, @reading_interval)

    :telemetry.attach(
      "dht_reader",
      [:dht, :read],
      &HomeTelemetry.SensorEventHandler.handle_event/4,
      nil
    )
  end
end
