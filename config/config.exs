# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :home_telemetry, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1609169802"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

config :home_telemetry, HomeTelemetry.SeriesConnection,
  auth: [method: :basic, username: "collector", password: "collector"],
  database: "readings",
  host: "192.168.0.33",
  port: 8086

if Mix.target() == :host or Mix.target() == :"" do
  import_config "host.exs"
else
  import_config "target.exs"
end
