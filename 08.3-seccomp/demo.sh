#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-08"

start_demo "Yay! seccomp filtering"

command "docker run --rm -it teaching/demos/debian"
command "strace ls"
printf "\n"
command "docker run --rm -it --security-opt seccomp=no-exec teaching/demos/debian"
printf "\n"
command "docker run --rm -it --security-opt seccomp=filter-write teaching/demos/debian"
command "ls -la"

stop_demo
