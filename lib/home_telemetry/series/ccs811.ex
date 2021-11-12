defmodule HomeTelemetry.Series.CCS811 do
  @moduledoc false

  use Instream.Series

  series do
    measurement("CCS811")

    field(:eco2)
    field(:tvoc)

    tag(:collector)
  end
end
