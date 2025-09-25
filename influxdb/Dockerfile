FROM influxdb:2.7

ENV DOCKER_INFLUXDB_INIT_MODE=setup \
    DOCKER_INFLUXDB_INIT_USERNAME=my-user \
    DOCKER_INFLUXDB_INIT_PASSWORD=my-super-secret-password \
    DOCKER_INFLUXDB_INIT_ORG=my-org \
    DOCKER_INFLUXDB_INIT_BUCKET=my-bucket


    RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

EXPOSE 8086