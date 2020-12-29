## Installation
1. `bash -c "$(wget -O- https://raw.githubusercontent.com/Efesto/home_telemetry/master/server/install-grafana_and_db.sh)"` Grafana and DB

## How to configure Grafana for authentication-free dashboard
1. refer to https://grafana.com/docs/grafana/latest/installation/configuration/ for adding the following to grafana config
```
[auth.proxy]
auto_sign_up = true
enabled = true
```
