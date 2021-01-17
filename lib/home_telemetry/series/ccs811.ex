defmodule HomeTelemetry.Series.CCS811 do
  use Instream.Series

  series do
    measurement("CCS811")

    field(:eco2)
    field(:tvoc)
  end
end
