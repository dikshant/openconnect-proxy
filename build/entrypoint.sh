#!/bin/sh

tinyproxy

run () {
  echo $OPENCONNECT_PASSWORD | openconnect --servercert pin-sha256:kzxsqW1zeKyDqJEZnsVFqgA+nXMSR2JlyejZQv+vS68= --juniper -u $OPENCONNECT_USER $OPENCONNECT_OPTIONS --no-dtls --passwd-on-stdin -v $OPENCONNECT_URL
}

until (run); do
  echo "openconnect exited. Restarting process in 5 seconds…" >&2
  sleep 5
done

