#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="mscs-demo-03"

start_demo "You can now demonstrate how to build docker images"

command "go run hello-world.go"
command "go build hello-world.go && docker build -t mscs/demo/03 ."
command "docker run --rm --name ${CONTAINER_NAME} mscs/demo/03"

printf "\n"

question "What happens if we try to run bash?"
command "docker run --rm -it --name ${CONTAINER_NAME} mscs/demo/03 bash"

printf "\n"

info "We can inspect the image with \`dive\` to see what's inside"
command "dive mscs/demo/03"

stop_demo