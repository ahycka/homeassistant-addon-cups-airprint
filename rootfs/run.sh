#!/usr/bin/with-contenv bashio

ulimit -n 1048576

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
# Create if not exists
if [ ! -d "/data/cups" ]; then
  cp -v -R /etc/cups /data
  rm -v -fR /etc/cups
  ln -v -s /data/cups /etc/cups
fi

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
