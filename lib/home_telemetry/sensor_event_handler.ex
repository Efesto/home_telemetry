defmodule HomeTelemetry.SensorEventHandler do
  @moduledoc """
  Collects sensor events and sends them to the time series database
  """

  alias HomeTelemetry.Series.{DHT22, CCS811}
  alias HomeTelemetry.SeriesConnection

  require Logger

  def handle_event([:dht, :read], %{temperature: temp, humidity: humidity}, _metadata, _config) do
    Logger.info("Temperature: #{temp} C")
    Logger.info("Humidity: #{humidity} %")

    data = %DHT22{}

    SeriesConnection.write(%{
      data
      | fields: %{data.fields | temperature: temp, humidity: humidity}
    })
  end

  def handle_event([:ccs811, :read], %{eco2: eco2, tvoc: tvoc}, _metadata, _config) do
    Logger.info("eCO2: #{eco2} ppm")
    Logger.info("TVOC: #{tvoc} ppm")

    data = %CCS811{}

    SeriesConnection.write(%{
      data
      | fields: %{data.fields | eco2: eco2, tvoc: tvoc}
    })
  end

  def attach do
    :telemetry.attach_many(
      "sensors_read_handler",
      [[:dht, :read], [:ccs811, :read]],
      &handle_event/4,
      nil
    )
  end
end
