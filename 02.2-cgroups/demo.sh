#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-02"

start_demo "You can now show how cgroups work"

command "docker run --rm -it --name ${CONTAINER_NAME} --memory 6m python:slim"
command "docker run --rm -it --name ${CONTAINER_NAME} --memory 20m python:slim"

printf "\n"

question "What happens if I try to allocate a big list? (e.g. [0] * 100_000_000)"

stop_demo
