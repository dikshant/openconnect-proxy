#!/bin/sh

/usr/local/bin/microsocks -i 0.0.0.0 -p 8888 & 

run () {
  echo $OPENCONNECT_PASSWORD | openconnect --servercert pin-sha256:6t2nJXB+zHa/LF2YIvCO613/KdUtltxW5f7TNtblL/g= --juniper -u $OPENCONNECT_USER $OPENCONNECT_OPTIONS --no-dtls --passwd-on-stdin -v $OPENCONNECT_URL
}

until (run); do
  echo "openconnect exited. Restarting process in 5 seconds…" >&2
  sleep 5
done

