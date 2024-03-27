#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-02" # change it in zellij too

start_demo "You can now show how namespaces are created and how they behave"

command "sudo unshare -n ip -c a # will run the command in a new network namespace"
command "sudo unshare -fp /bin/bash -c \"echo \$\$\" # will display bash's PID inside the namespace... or will it?"
command "sudo unshare -fp /bin/bash -c 'echo \$\$' # will really display bash's PID inside the namespace"

printf "\n"

info "You can also demonstrate this with a container:"
command "docker run --rm -it --name ${CONTAINER_NAME} teaching/demos/debian"
command "docker top ${CONTAINER_NAME}"
command "docker exec ${CONTAINER_NAME} ip -c a"
command "docker exec ${CONTAINER_NAME} ps -aux"

printf "\n"

info "You're feeling adventurous? You can even enter the container's namespaces:"
command "sudo nsenter -t \$(docker inspect --format '{{ .State.Pid }}' ${CONTAINER_NAME}) -u hostname"
command "sudo nsenter -t \$(docker inspect --format '{{ .State.Pid }}' ${CONTAINER_NAME}) -n ip -c a"
command "sudo nsenter -t \$(docker inspect --format '{{ .State.Pid }}' ${CONTAINER_NAME}) -a bash"

stop_demo
