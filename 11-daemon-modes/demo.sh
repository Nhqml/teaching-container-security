#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-11"

start_demo "Docker daemon modes userns-remap and rootless"

info "userns-remap has been enabled in the daemon config"
command "cat /etc/docker/daemon.json"

printf "\n"

info "I lied to you earlier when I said \"I'm root\", I was not..."
command "docker run --rm -it --name ${CONTAINER_NAME} -v /:/host alpine chroot /host"
command "id && ls -lan /"
command "touch /tmp/a-im-really-root"

info "On the host, you see that I'm not root on the container"
command "sudo lsns -p \$(docker inspect --format '{{.State.Pid}}' ${CONTAINER_NAME})"
command "ls -lan /tmp/a-im-really-root"

info "Docker will remap users and groups to a range of subuids and subgids"
command "grep dock /etc/subuid"

printf "\n"

attention "This can be disabled on a per-container basis"
command "docker run --rm -it --name ${CONTAINER_NAME} -v /:/host --userns=host alpine chroot /host"

printf "\n"

info "Now let's have a quick look at the rootless mode"
command "docker context use rootless"

printf "\n"

info "Everything looks normal"
command "docker run --rm -it teaching/demo/debian"

info "But we cannot bind to privileged ports since we're not root anymore"
command "docker run --rm -it -p 80:80 teaching/demo/debian"

info "Cant we?"
command "sudo setcap 'cap_net_bind_service=ep' /usr/bin/rootlesskit && systemctl --user restart docker"

stop_demo
