#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-06"

start_demo "You can now demonstrate how to build multi-stage images"

info "Let's start with a naive Dockerfile"
command "docker build -f Dockerfile.naive -t teaching/demos/06-naive ."
command "docker run --rm --name ${CONTAINER_NAME} teaching/demos/06-naive"
command "docker inspect --format='{{.Size}}' teaching/demos/06-naive | numfmt --to=si --suffix=B"

printf "\n"

info "Now let's try something better"
command "docker build -f Dockerfile.multi-stage -t teaching/demos/06-multi-stage ."
command "docker run --rm --name ${CONTAINER_NAME} teaching/demos/06-multi-stage"
command "docker inspect --format='{{.Size}}' teaching/demos/06-multi-stage | numfmt --to=si --suffix=B"

printf "\n"

stop_demo
