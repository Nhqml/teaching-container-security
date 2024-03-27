#!/usr/bin/env bash

set -eo pipefail

[[ -n "${DEBUG}" ]] && set -x

_SCRIPT_DIR="$(dirname "$0")"

docker buildx b "$@" -t "teaching/demos/debian" "${_SCRIPT_DIR}"

pushd "${_SCRIPT_DIR}/03-build"
go build hello-world.go
docker buildx b "$@" -t "teaching/demos/03" .
docker buildx b "$@" -t "teaching/demos/03-debian" -f Dockerfile.debian .
popd

docker buildx b "$@" -t "teaching/demos/04" "${_SCRIPT_DIR}/04-config"

pushd "${_SCRIPT_DIR}/06-multi-layers"
docker buildx b "$@" -t "teaching/demos/06-naive" -f Dockerfile.naive .
docker buildx b "$@" -t "teaching/demos/06-multi-stage" -f Dockerfile.multi-stage .
popd
