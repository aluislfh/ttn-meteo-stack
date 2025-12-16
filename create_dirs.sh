mkdir -p ~/ttn-meteo-stack
mkdir -p ~/ttn-meteo-stack/exporter
mkdir -p ~/ttn-meteo-stack/prometheus

mkdir -p ~/ttn-meteo-stack/grafana/provisioning/datasources
mkdir -p ~/ttn-meteo-stack/grafana/provisioning/dashboards
mkdir -p ~/ttn-meteo-stack/grafana/dashboards
mkdir -p ~/ttn-meteo-stack/grafana_data

cd ~/ttn-meteo-stack


touch ~/ttn-meteo-stack/docker-compose.yml
touch ~/ttn-meteo-stack/.env

touch ~/ttn-meteo-stack/exporter/Dockerfile
touch ~/ttn-meteo-stack/exporter/exporter.py
touch ~/ttn-meteo-stack/exporter/requirements.txt

touch ~/ttn-meteo-stack/prometheus/prometheus.yml

touch ~/ttn-meteo-stack/grafana/provisioning/datasources/datasource.yml
touch ~/ttn-meteo-stack/grafana/provisioning/dashboards/dashboards.yml

touch ~/ttn-meteo-stack/grafana/dashboards/meteo.json
touch ~/ttn-meteo-stack/grafana/dashboards/hydro.json