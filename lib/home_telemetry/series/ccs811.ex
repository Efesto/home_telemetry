defmodule HomeTelemetry.Series.CCS811 do
  use Instream.Series

  series do
    measurement("CCS811")

    field(:co2)
    field(:tvoc)
  end
end