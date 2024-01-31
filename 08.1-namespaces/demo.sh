#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="mscs-demo-08"

start_demo --split "Let's play a bit with namespaces"

command "docker run --rm -it --name ${CONTAINER_NAME} --network=host mscs/demo/debian"
command "ip -c a"

info "You're in the same network namespace as the host"

command "sudo lsns -p \$(docker inspect --format '{{.State.Pid}}' ${CONTAINER_NAME})"

printf "\n"

info "You can do the same with the PID, UTS, etc. namespaces"

stop_demo --split
