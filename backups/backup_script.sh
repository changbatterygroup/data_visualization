#!/bin/bash

# This script will backup all the data needed to restore this environment in case of failure.
# all of the backup data will be stored on one drive folder defined in the .env file.
# Backups 7 days or older will be deleted when this script runs.

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

source "$(dirname "$0")/.env"

DATE=$(date +%Y-%m-%d)
TARGET_DIR="$ONE_DRIVE_FOLDER/$DATE"
RETENTION_DAYS=7

mkdir -p "$TARGET_DIR"

echo -e "\n\n BACKUP STARTING $DATE"
echo "Starting InfluxDB backup..."

docker exec influxdb influx backup /tmp/backup_influx \
  --token "$INFLUX_TOKEN"

docker cp influxdb:/tmp/backup_influx "$TARGET_DIR/influxdb_backup"
docker exec influxdb rm -rf /tmp/backup_influx


echo "Backing up Grafana and Mosquitto volumes..."
docker run --rm \
  --volumes-from grafana \
  -v "$TARGET_DIR":/backup \
  alpine \
  tar czf /backup/grafana_data.tar.gz /var/lib/grafana

docker run --rm \
  --volumes-from mqtt_broker \
  -v "$TARGET_DIR":/backup \
  alpine \
  tar czf /backup/mosquitto_data.tar.gz /mosquitto/data


find "$TARGET_DIR" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} +

echo "Backup Complete: $DATE"
