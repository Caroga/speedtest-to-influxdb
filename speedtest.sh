#!/bin/sh
set -e

echo "[info][$(date)] Starting speedtest..."

JSON=$(speedtest-cli --json)

ISP_NAME=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['client']['isp']" | sed 's/ /\\ /g')
ISP_IP=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['client']['ip']")
ISP_LON=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['client']['lon']")
ISP_LAT=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['client']['lat']")
DOWNLOAD=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['download']")
UPLOAD=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['upload']")
SERVER_PING=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['ping']")
SERVER_NAME=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['server']['name']" | sed 's/ /\\ /g')
SERVER_LON=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['server']['lon']")
SERVER_LAT=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['server']['lat']")
SERVER_NAME_SPONSOR=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['server']['sponsor']" | sed 's/ /\\ /g')
SERVER_ID=$(echo "${JSON}" | python -c "import sys, json; print json.load(sys.stdin)['server']['id']")

echo "[info][$(date)] Speedtest results: "
echo "[info][$(date)] -- Your ISP name: ${ISP_NAME}"
echo "[info][$(date)] -- Your IP: ${ISP_IP}"
echo "[info][$(date)] -- Server: ${SERVER_NAME_SPONSOR} ${SERVER_NAME}"
echo "[info][$(date)] -- Measured ping: ${SERVER_PING}ms"
echo "[info][$(date)] -- Measured download speed: ${DOWNLOAD}"
echo "[info][$(date)] -- Measured upload speed: ${UPLOAD}"

QUERY='speedtests,host='${HOST}',isp_name='${ISP_NAME}',isp_ip='${ISP_IP}',isp_lon='${ISP_LON}',isp_lat='${ISP_LAT}',server_name='${SERVER_NAME}',server_lon='${SERVER_LON}',server_lat='${SERVER_LAT}',server_name_sponsor='${SERVER_NAME_SPONSOR}',server_id='${SERVER_ID}' download='${DOWNLOAD}',upload='${UPLOAD}',ping='${SERVER_PING}
echo "${QUERY}" > /tmp/postdata
curl -s -XPOST -u ${INFLUX_DB_USER}:${INFLUX_DB_PASSWORD} "${INFLUXDB_HOST}/write?db=${INFLUXDB_DB}" --data-binary @/tmp/postdata
echo "[info][$(date)] Done!"
echo ''
