defmodule HomeTelemetry.SensorEventHandler do
  @moduledoc """
  Collects sensor events and sends them to the time series database
  """

  alias HomeTelemetry.Series.{DHT22, CCS811}
  alias HomeTelemetry.SeriesConnection

  require Logger

  def handle_event([:dht, :read], event, _metadata, _config) do
    write_event(%DHT22{}, event |> Map.take([:temperature, :humidity]))
  end

  def handle_event([:ccs811, :read], event, _metadata, _config) do
    write_event(%CCS811{}, event |> Map.take([:eco2, :tvoc]))
  end

  defp write_event(data, event) do
    {:ok, collector_name} = :inet.gethostname()
    tags = Map.merge(data.tags, %{collector: collector_name})
    fields = Map.merge(data.fields, event)

    data = %{data | fields: fields, tags: tags}
    Logger.debug(inspect(data))

    SeriesConnection.write(data)
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
