#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"

start_demo "You can now demonstrate docker uses of networks"

command "docker network ls\n"

info "Without specifying anything, the containers are started in the default network\n"
task "Start two of them"
command "docker run --rm -it mscs/demo/debian\n"
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
command "docker run --rm -it --network=d34d mscs/demo/debian"

printf "\n"

info "We can also create internal networks to prevent containers from communicating with anything that's not on their network"
command "docker run --rm -it --network=internal mscs/demo/debian"

printf "\n"

info "Finally, we can also prevent networking entirely"
command "docker run --rm -it --network=none mscs/demo/debian"

printf "\n"

stop_demo
