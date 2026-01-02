mkdir -p ~/ttn-meteo-stack
mkdir -p ~/ttn-meteo-stack/exporter
mkdir -p ~/ttn-meteo-stack/prometheus

mkdir -p ~/ttn-meteo-stack/grafana/provisioning/datasources
mkdir -p ~/ttn-meteo-stack/grafana/provisioning/dashboards
mkdir -p ~/ttn-meteo-stack/grafana/dashboards
mkdir -p ~/ttn-meteo-stack/grafana_data

mkdir -p ~/ttn-meteo-stack/airflow
mkdir -p ~/ttn-meteo-stack/airflow/airflow/{dags,logs,plugins,config,code}

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

touch ~/ttn-meteo-stack/airflow/docker-compose.yaml
touch ~/ttn-meteo-stack/airflow/.env


sudo chown -R 472:472 grafana_data
sudo chown -R 50000:999 ./airflow
