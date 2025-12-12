#!/usr/bin/env python3
import os
import json
import time
import threading
import paho.mqtt.client as mqtt
from prometheus_client import Gauge, start_http_server

# -----------------------------
# Config TTN / MQTT por entorno
# -----------------------------
MQTT_HOST = os.getenv("TTN_MQTT_HOST", "nam1.cloud.thethings.network")
MQTT_PORT = int(os.getenv("TTN_MQTT_PORT", "8883"))
MQTT_USERNAME = os.getenv("TTN_MQTT_USERNAME")
MQTT_PASSWORD = os.getenv("TTN_MQTT_PASSWORD")
MQTT_TOPIC = os.getenv("TTN_MQTT_TOPIC", "v3/+/devices/+/up")

METRICS_PORT = int(os.getenv("METRICS_PORT", "8000"))

if not MQTT_USERNAME or not MQTT_PASSWORD:
    raise RuntimeError("Faltan TTN_MQTT_USERNAME o TTN_MQTT_PASSWORD")

# -----------------------------
# Métricas Prometheus
#  "meteo", "hydro", "unknown"
# -----------------------------
sensor_value = Gauge(
    "ttn_sensor_value",
    "Valor de variable sensor TTN (decoded_payload)",
    ["app_id", "device_id", "device_type", "field"]
)


def classify_device_type(device_id: str) -> str:
    """
    Clasifica el tipo de dispositivo según su prefijo.
    - wst506-xxx  -> meteo
    - em500-udl-x -> hydro
    """
    if device_id.startswith("wst506"):
        return "meteo"
    if device_id.startswith("em500-udl"):
        return "hydro"
    return "unknown"


# -----------------------------
# Callbacks MQTT
# -----------------------------
def on_connect(client, userdata, flags, rc):
    print("Conectado a TTN MQTT, rc =", rc)
    client.subscribe(MQTT_TOPIC)
    print("Suscrito a tópico:", MQTT_TOPIC)


def on_message(client, userdata, msg):
    try:
        payload = json.loads(msg.payload.decode("utf-8"))
    except Exception as e:
        print("Error parseando JSON:", e)
        return

    app_id = (
        payload.get("end_device_ids", {})
        .get("application_ids", {})
        .get("application_id", "unknown_app")
    )

    device_id = (
        payload.get("end_device_ids", {})
        .get("device_id", "unknown_device")
    )

    device_type = classify_device_type(device_id)

    uplink = payload.get("uplink_message", {})
    decoded = uplink.get("decoded_payload", {})


    if isinstance(decoded, dict):
        for field, value in decoded.items():

            try:
                v = float(value)
            except (TypeError, ValueError):
                continue

            sensor_value.labels(
                app_id=app_id,
                device_id=device_id,
                device_type=device_type,
                field=field
            ).set(v)


def mqtt_loop():
    client = mqtt.Client()
    client.username_pw_set(MQTT_USERNAME, MQTT_PASSWORD)
    client.tls_set()  # TLS por defecto

    client.on_connect = on_connect
    client.on_message = on_message

    client.connect(MQTT_HOST, MQTT_PORT, 60)
    client.loop_forever()


def main():

    start_http_server(METRICS_PORT)
    print(f"Servidor de métricas en :{METRICS_PORT}/metrics")

    t = threading.Thread(target=mqtt_loop, daemon=True)
    t.start()

    while True:
        time.sleep(60)


if __name__ == "__main__":
    main()
