#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-08"

start_demo "Can AppArmor stop me?"

command "sudo apparmor_parser -rW profile"
command "docker run --rm -it --security-opt apparmor=docker-teaching teaching/demo/debian"
command "sudo apparmor_parser -R profile # remove the profile"

stop_demo
