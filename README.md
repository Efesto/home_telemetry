# HomeTelemetry

Collects and sends to an InfluxDb instance home related telemetry data like Temperature and Humidity.
Developed using [Nerves](https://www.nerves-project.org/)

## Requirements:
* Asdf (everything else will come from there)
* Nerves (`mix archive.install hex nerves_bootstrap`)

## Getting Started
1. `mix deps.get`
2. configure env variables specified in `.envrc-sample` 
    1. If using direnv, copy `.envrc-sample` as `.envrc` and configure it
3. build your firmware with `MIX_TARGET=my_target mix firmware` For example, `MIX_TARGET=rpi3`
4. burn to you sd card using `mix firmware.burn`

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
