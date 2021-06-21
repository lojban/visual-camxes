#!/bin/bash

exec 2>&1
set -e
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

./kill_container.sh "$@"

./build_container.sh "$@"

web_port=13080

# our sub-version number; used to force rebuilds
# MUST change this both here and in build_web.sh
ITERATION=1

# Ask for a tty if that makes sense
hasterm=''
if tty -s
then
        hasterm='-t'
fi

echo
echo "Setting up config files and the like."
echo

./fix_selinux.sh

echo
echo "Launching website container, which will listen on web_port $web_port"
echo

$CONTAINER_BIN run --userns=keep-id --name lojban_visual_camxes -p $web_port:8080 \
        -v /home/sampre_cx/visual_camxes:/home/sampre_cx/visual_camxes \
        -i $hasterm lojban/visual_camxes:$ITERATION \
        bash -c "gunicorn wsgi:app --access-logfile - --error-logfile - --access-logformat '%(h)s %({x-forwarded-for}i)s %(l)s %(u)s %(t)s \"%(r)s\" %(s)s %(b)s \"%(f)s\" \"%(a)s\"' -w 1 -b 0.0.0.0:8080"
