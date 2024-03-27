#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"

start_demo "You can now demonstrate docker uses of networks"

command "docker network ls\n"

info "Without specifying anything, the containers are started in the default network\n"
task "Start two of them"
command "docker run --rm -it teaching/demos/debian\n"
info "They can communicate with each other!"
command "ip -c a"
command "ping 172.17.0.3"
command "nc -l -p 1234"

printf "\n"

info "By default, Docker will also allow containers to communicate with the host and the Internet"
command "ping 1.1.1.1"
command "nc 172.17.0.1 1234"

printf "\n"

info "Docker allow to create custom networks, to isolate containers"
command "docker network create d34d --opt com.docker.network.bridge.name=br-d34d"
command "docker network create b33f --opt com.docker.network.bridge.name=br-b33f"
command "docker run --rm -it --network=d34d teaching/demos/debian"

printf "\n"

info "We can also create internal networks to prevent containers from communicating with anything that's not on their network"
command "docker network create --internal internal"
command "docker run --rm -it --network=internal teaching/demos/debian"

printf "\n"

info "Finally, we can also prevent networking entirely"
command "docker run --rm -it --network=none teaching/demos/debian"

printf "\n"

stop_demo
