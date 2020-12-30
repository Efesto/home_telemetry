defmodule HomeTelemetry.Sensors.CCS811 do
  alias Circuits.I2C
  use Bitwise

  def initialize() do
    %{app_valid: true, error: false, fw_mode: false} = read_status()
    :ok = write_app_start()
    %{app_valid: true, error: false, fw_mode: true} = read_status()

    :ok
  end

  @registries %{
    status: %{address: 0x00, bytes: 1, read: true, write: false},
    meas_mode: %{address: 0x01, bytes: 1, read: true, write: true},
    alg_result_data: %{address: 0x02, bytes: 8, read: true, write: false},
    raw_data: %{address: 0x03, bytes: 2, read: true, write: false},
    env_data: %{address: 0x05, bytes: 4, read: false, write: true},
    ntc: %{address: 0x06, bytes: 4, read: true, write: false},
    thresholds: %{address: 0x10, bytes: 5, read: false, write: true},
    baseline: %{address: 0x11, bytes: 2, read: true, write: true},
    hw_id: %{address: 0x20, bytes: 1, read: true, write: false},
    hw_version: %{address: 0x21, bytes: 1, read: true, write: false},
    fw_boot_version: %{address: 0x23, bytes: 2, read: true, write: false},
    fw_app_version: %{address: 0x24, bytes: 2, read: true, write: false},
    error_id: %{address: 0xE0, bytes: 1, read: true, write: false},
    app_verify: %{address: 0xF3, bytes: 0, read: false, write: true},
    app_start: %{address: 0xF4, bytes: 0, read: false, write: true},
    sw_reset: %{address: 0xFF, bytes: 4, read: false, write: true}
  }

  @registries
  |> Enum.each(fn {key, %{address: address, bytes: bytes, read: read, write: write}} ->
    if read do
      def unquote(:"read_#{key}")() do
        read_registry(unquote(address), unquote(bytes))
        |> translate(unquote(key))
      end
    end

    case {write, bytes} do
      {true, 0} ->
        def unquote(:"write_#{key}")() do
          write_registry(unquote(address))
        end

      {true, _} ->
        def unquote(:"write_#{key}")(data) do
          write_registry(unquote(address), data)
        end

      {_, _} ->
        nil
    end
  end)

  defp translate({:ok, <<read>>}, :status) do
    %{
      fw_mode: read |> bit_mask(128),
      app_valid: read |> bit_mask(16),
      data_ready: read |> bit_mask(8),
      error: read |> bit_mask(1)
    }
  end

  defp translate({:ok, <<read>>}, :meas_mode) do
    drive_mode =
      case read &&& 112 do
        0 -> :mode_0
        16 -> :mode_1
        32 -> :mode_2
        48 -> :mode_3
        64 -> :mode_4
      end

    %{
      drive_mode: drive_mode,
      int_threshold: read |> bit_mask(4),
      int_data_ready: read |> bit_mask(8)
    }
  end

  defp translate({:ok, <<read>>}, :error_id) do
    %{
      write_reg_invalid: read |> bit_mask(1),
      red_reg_invalid: read |> bit_mask(2),
      measmode_invalid: read |> bit_mask(4),
      max_resistance: read |> bit_mask(8),
      heater_fault: read |> bit_mask(16),
      heater_supply: read |> bit_mask(32)
    }
  end

  defp translate(
         {:ok,
          <<eco2_high_byte, eco2_low_byte, tvoc_high_byte, tvoc_low_byte, status, error_id,
            _raw_data1, _raw_data2>>},
         :alg_result_data
       ) do
    %{
      status: translate({:ok, <<status>>}, :status),
      error_id: translate({:ok, <<error_id>>}, :error_id),
      eco2: %{high: eco2_high_byte, low: eco2_low_byte},
      tvoc: %{high: tvoc_high_byte, low: tvoc_low_byte}
    }
  end

  defp translate({:ok, <<major::4, minor::4, trivial>>}, :fw_app_version) do
    "#{major}.#{minor}.#{trivial}"
  end

  defp translate({:ok, read}, _), do: read

  defp bit_mask(value, mask) do
    (value &&& mask) > 0
  end

  @slave_address 0x5A
  def read_registry(registry, bytes) do
    {:ok, ref} = open()
    I2C.write_read(ref, @slave_address, [registry], bytes)
  end

  def write_registry(registry, data) do
    {:ok, ref} = open()
    I2C.write(ref, @slave_address, [registry, data])
  end

  def write_registry(registry) do
    {:ok, ref} = open()
    I2C.write(ref, @slave_address, [registry])
  end

  defp open do
    I2C.open("i2c-1")
  end
end
