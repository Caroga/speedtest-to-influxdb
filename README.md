# Speedtest to InfluxDB

Easy setup to run speedtest-cli and push the results to your InfluxDB instance.
Images provided for the following platforms:
```
linux/amd64, linux/arm64, linux/arm/v6, linux/arm/v7
```

## Breaking it down
Before starting it is good to know that for influxdb the following structure is being used by this script:

**Measurement: speedtests**

| Tags                  | Values    |
|:--------------------: | --------: |
| host                  | download  |
| isp_name              |   upload  |
| isp_ip                |   ping    |
| isp_lon               |           |
| isp_lat               |           |
| server_name           |           |
| server_lon            |           |
| server_lat            |           |
| server_name_sponsor   |           |
| server_id             |           |

## Setup
The following environment variables are available:
```
- CLIENT=<hostname or some other identifier>
- INFLUXDB_HOST=
- INFLUXDB_DB=
- INFLUX_DB_USER=
- INFLUX_DB_PASSWORD=
```
Run the image with the following one-liner:
```
docker run --rm -it -e "CLIENT=myhostname" -e "INFLUXDB_HOST=hosturl.com" -e "INFLUXDB_DB=speedtest" -e "INFLUX_DB_USER=speedtest" -e "INFLUX_DB_PASSWORD=speedtest" caroga/speedtest-to-influxdb:latest
```

## Crontab
Will run the docker instance every 20 minutes.

```
*/20 * * * *  root docker run --rm -it -e "CLIENT=myhostname" -e "INFLUXDB_HOST=hosturl.com" -e "INFLUXDB_DB=speedtest" -e "INFLUX_DB_USER=speedtest" -e "INFLUX_DB_PASSWORD=speedtest" caroga/speedtest-to-influxdb:latest
```
