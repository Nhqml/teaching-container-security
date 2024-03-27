#!/usr/bin/env sh

DEMO_DIR="$(dirname "$(realpath "$0")")"
DEMO_SLUG="$(basename "${DEMO_DIR}")"

source "${DEMO_DIR}/../_utils.sh"

TAB_NAME="Demo ${DEMO_SLUG}"
CONTAINER_NAME="teaching-demo-02"

start_demo --split "You can now show how to scan images, etc."

task "Generate a SBOM"
command "syft alpine:latest"

printf "\n"

task "Scan an image"
command "grype alpine:latest"

printf "\n"

task "Scan the image from its SBOM"
command "syft -o json alpine:latest | grype"

printf "\n"

info "Different scanners may have different results"
command "trivy image alpine:latest"

stop_demo --split
