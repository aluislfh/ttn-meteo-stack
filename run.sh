#!/bin/bash

#-------------------------------------------------------------------------
# Excecute Prometheus and Grafana con Docker Compose
#-------------------------------------------------------------------------

# Build and run the Docker Compose services
sudo docker-compose build
sudo docker-compose up -d

# Check that the containers are running
sudo docker ps

# Test the exporter endpoint
curl http://localhost:8000/metrics
# Example output:
# ttn_sensor_value{app_id="tu_app",device_id="wst506-001",field="temperature"} 20.6
# ttn_sensor_value{app_id="tu_app",device_id="wst506-002",field="humidity"} 99.5

# Check grafana:
# http://localhost:9090
# consultar: ttn_sensor_value

#-------------------------------------------------------------------------
# Excecute Grafana and make dashboards
#-------------------------------------------------------------------------

# Navegador → http://localhost:3000
# Usuario: admin
# Password: admin (recordar cambiarla).

# Añadir Data Source:

# Type: Prometheus

# URL: http://prometheus:9090

# Save & Test

# Crear Dashboard → Add panel → Query:


#-------------------------------------------------------------------------
# Ejecutar airflow
#-------------------------------------------------------------------------

cd ~/ttn-meteo-stack/airflow

sudo docker compose up airflow-init
sudo docker compose up -d
sudo docker compose ps
