FROM influxdb:2.7

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENV INFLUXD_HTTP_BIND_ADDRESS=:8086


EXPOSE 8086