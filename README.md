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
- HOST=<hostname or some other identifier>
- INFLUXDB_HOST=
- INFLUXDB_DB=
- INFLUX_DB_USER=
- INFLUX_DB_PASSWORD=
```

The port is not defined by default, so if you want to connect to a specific port, you can provide it with a semi-colon, for example: `hosturl.com:8086`.

Run the image with the following one-liner:
```
docker run --rm -e "HOST=myhostname" -e "INFLUXDB_HOST=hosturl.com" -e "INFLUXDB_DB=speedtest" -e "INFLUX_DB_USER=speedtest" -e "INFLUX_DB_PASSWORD=speedtest" caroga/speedtest-to-influxdb:latest
```

## Crontab
Will run the docker instance every 20 minutes.

```
*/20 * * * *  root docker run --rm -e "HOST=myhostname" -e "INFLUXDB_HOST=hosturl.com" -e "INFLUXDB_DB=speedtest" -e "INFLUX_DB_USER=speedtest" -e "INFLUX_DB_PASSWORD=speedtest" caroga/speedtest-to-influxdb:latest
```

# F.A.Q
**Running the image interactively**
You can add `-it` to the command above to run the image interactively: `docker run --rm -it -e "HOST...`

**It doesn't seem to work, can I debug some more information?**
At the moment there is no debug settings implemented, but by running the container interactively you can change the script located at `/bin/rspeedtest` to remove the `-s` on line 31. This will possible give you some more feedback.
