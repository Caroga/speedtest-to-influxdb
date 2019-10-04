FROM alpine:3.10.2

COPY speedtest.sh /bin/rspeedtest
RUN apk add --no-cache curl python speedtest-cli \
    && chmod +x /bin/rspeedtest

CMD rspeedtest
