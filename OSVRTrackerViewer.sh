#!/bin/bash

# pragmatically link to relevant running containers (osvr-server)
LINKS=""
for c in $(docker ps -q --filter "name=osvr-server")
do
    LINKS="$LINKS --link $(docker inspect --format='{{.Config.Hostname}}' $c)"
done

_PWD="$(readlink -f $(dirname $0))"
${_PWD}/xlaunch.sh \
    --env OSVR_HOST=osvr-server:3883 \
    --hostname osvr-tracker-viewr \
    --name osvr-tracker-viewer \
    --rm \
    ${LINKS} \
    osvr/tracker-viewer:latest \
    OSVRTrackerView \
    ${@}
