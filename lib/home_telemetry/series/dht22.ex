defmodule HomeTelemetry.Series.DHT22 do
  use Instream.Series

  series do
    measurement("DHT-22")

    field(:temperature)
    field(:humidity)
  end
end
