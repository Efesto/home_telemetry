defmodule HomeTelemetry.SensorEventHandler do
  alias HomeTelemetry.Series.DHT22
  alias HomeTelemetry.Series.CCS811

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

  def handle_event([:ccs811, :read], %{co2: co2, tvoc: tvoc}, _metadata, _config) do
    Logger.info("CO2: #{co2} ppm")
    Logger.info("TVOC: #{tvoc} ppm")

    data = %CCS811{}

    HomeTelemetry.SeriesConnection.write(%{
      data
      | fields: %{data.fields | co2: co2, tvoc: tvoc}
    })
  end

  def attach do
    :telemetry.attach_many(
      "sensors_read_handler",
      [[:dht, :read], [:ccs811, :read]],
      &HomeTelemetry.SensorEventHandler.handle_event/4,
      nil
    )
  end
end
