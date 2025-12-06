#!/bin/bash

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
# Conectar Grafana y hacer el primer dashboard
#-------------------------------------------------------------------------

# Navegador → http://localhost:3000
# Usuario: admin
# Password: admin (es obligado cambiarla).

# Añadir Data Source:

# Type: Prometheus

# URL: http://prometheus:9090

# Save & Test

# Crear Dashboard → Add panel → Query:

# ttn_sensor_value{field="temperature"}

# En “Legend” pon:

# {{device_id}}

# Se mostrarán dos curvas: wst506-001 y wst506-002.
# Luego repetir para humidity, pressure, wind_speed, rainfall_total, etc.