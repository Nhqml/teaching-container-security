#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-08"

start_demo --split "Let's play with capabilities and privileges"

attention "Using --privileged is really not a good idea! Please don't do this on your own"

task "Start by starting a normal container, without any special privileges (default config)"
command "docker run --rm -it --name ${CONTAINER_NAME} teaching/demos/debian"
command "ls -la /dev"

task "Now, let's start a container with the --privileged flag"
command "docker run --rm -it --name ${CONTAINER_NAME} --privileged teaching/demos/debian"

printf "\n"

info "You can see that the container has access to all devices on the host, including the disk..."
task "Create a secret file on the host"
command "echo \"s3cr3t\" > /tmp/secret.txt"
task "You have access to it from the container!!!"
command "mount /dev/nvme0n1p1 /mnt && cat /mnt/etc/hostname && cat /mnt/tmp/secret.txt"

printf "\n"

attention "You should be very very very very very careful with the --privileged flag, prefer the use of --cap-add and --cap-drop for more granular control"
command "docker run --rm -it --name ${CONTAINER_NAME} --cap-drop=CHOWN teaching/demos/debian"
command "chown nobody /var"

stop_demo --split
