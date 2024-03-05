#!/bin/bash

# TODO: add a flag so I can skip rebuilding
# TODO: give specific IP addresses
# TODO: does this actually execute as root?
#
# please run this shit as root
podman build -t echo_server -f server/echo_server.dockerfile
podman build -t postgres_db -f db/postgres_db.dockerfile

podman run -dit --rm localhost/echo_server
podman run -dit --rm localhost/postgres_db

