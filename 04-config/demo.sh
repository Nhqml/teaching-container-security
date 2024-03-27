#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-04"

start_demo "You can now explain a bit more docker run"

command "docker build -t teaching/demos/04 ."
command "docker run --rm --name ${CONTAINER_NAME} teaching/demos/04"

printf "\n"

info "But we can also allow the container to access some files on the host"
command "docker run --rm --name ${CONTAINER_NAME} -v ./config.json:/config.json:ro teaching/demos/04"

printf "\n"

info "And we can also pass environment variables"
command "docker run --rm --name ${CONTAINER_NAME} -e APP_ID=2 teaching/demos/04"

printf "\n"

stop_demo
