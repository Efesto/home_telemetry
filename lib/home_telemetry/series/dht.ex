defmodule HomeTelemetry.Series.DHT do
  @moduledoc false

  use Instream.Series

  series do
    measurement("DHT")

    field(:temperature)
    field(:humidity)

    tag(:collector)
  end
end
