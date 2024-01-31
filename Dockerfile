FROM debian:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends iproute2 procps iputils-ping netcat-traditional curl strace && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
