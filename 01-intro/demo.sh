#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"

start_demo --sync "You can now run these commands to present your environment and your Docker installation"

command "uname -srvm"
command "docker version"
command "docker run --rm hello-world"

stop_demo
