#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-09" # change it in zellij too

start_demo "We can expose services on the host with port forwarding"

task "Start a container and listen on ports 80 (HTTP) and 5432 (PostgreSQL)"
command "docker run --rm -it --name ${CONTAINER_NAME} -p 80:80 teaching/demos/debian"
command "while true; do nc -l -p 80; done& while true; do nc -l -p 5432; done&"

printf "\n"

task "Now on the host, connect to the container"
command "nc ${CONTAINER_NAME} 80"
command "nc ${CONTAINER_NAME} 5432"

printf "\n"

info "Since we exposed port 80, we can also connect from the host IP"
command "nc 127.0.0.1 80"
info "But we cannot connect to the port 5432"
command "nc 127.0.0.1 5432"

stop_demo
