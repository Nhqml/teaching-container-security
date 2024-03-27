#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-02"

start_demo "You can now show how cgroups work"

command "docker run --rm -it --name ${CONTAINER_NAME} --memory 10m python:slim"
command "docker run --rm -it --name ${CONTAINER_NAME} --memory 20m python:slim"

stop_demo
