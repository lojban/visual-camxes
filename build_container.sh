#!/bin/bash

exec 2>&1
set -e
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

# our container build version number; used to force rebuilds
ITERATION=1

echo
echo "Building visual_camxes container."
echo

$CONTAINER_BIN build --build-arg=CX_USERID=$(id -u) --build-arg=CX_GROUPID=$(id -g) \
        -t lojban/visual_camxes:$ITERATION \
        -f Dockerfile .
