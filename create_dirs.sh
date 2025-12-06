mkdir -p ~/ttn-meteo-stack
mkdir -p ~/ttn-meteo-stack/exporter
mkdir -p ~/ttn-meteo-stack/prometheus


cd ~/ttn-meteo-stack


touch ~/ttn-meteo-stack/docker-compose.yml
touch ~/ttn-meteo-stack/.env

touch ~/ttn-meteo-stack/exporter/Dockerfile
touch ~/ttn-meteo-stack/exporter/exporter.py
touch ~/ttn-meteo-stack/exporter/requirements.txt

touch ~/ttn-meteo-stack/prometheus/prometheus.yml