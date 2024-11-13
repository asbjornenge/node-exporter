#!/bin/sh

ARCH=$(uname -m)

if [ "$ARCH" = "aarch64" ]; then
    ln -sf /usr/bin/docker-aarch64 /usr/bin/docker
    ln -sf /usr/bin/jq-aarch64 /usr/bin/jq
elif [ "$ARCH" = "x86_64" ]; then
    ln -sf /usr/bin/docker-x86_64 /usr/bin/docker
    ln -sf /usr/bin/jq-x86_64 /usr/bin/jq
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

