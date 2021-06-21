#!/bin/bash

exec 2>&1
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

$CONTAINER_BIN stop --time=30 lojban_visual_camxes
$CONTAINER_BIN kill lojban_visual_camxes
$CONTAINER_BIN rm lojban_visual_camxes

exit 0
