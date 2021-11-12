defmodule HomeTelemetry.Series.DHT22 do
  @moduledoc false

  use Instream.Series

  series do
    measurement("DHT-22")

    field(:temperature)
    field(:humidity)

    tag(:collector)
  end
end
