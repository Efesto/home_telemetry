defmodule HomeTelemetry.NetStatusCheck do
  @moduledoc """
  Genserver that checks network connection status and sends a signal on GPIO if missing
  """

  use GenServer
  require Logger

  alias Circuits.GPIO

  @pin_io 27
  @polling_period 30_000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(_) do
    send_message()

    {:ok, %{}}
  end

  @impl true
  def handle_info(:check_status, state) do
    check_status()
    send_message()

    {:noreply, state}
  end

  defp send_message() do
    Process.send_after(self(), :check_status, @polling_period)
  end

  def check_status() do
    connection_status = VintageNet.get(["connection"])
    Logger.debug("Connection status: #{connection_status}")
    {:ok, ref} = GPIO.open(@pin_io, :output)

    case connection_status in [:lan, :internet] do
      true -> GPIO.write(ref, 0)
      _ -> GPIO.write(ref, 1)
    end
  end
end
