#!/bin/bash
_PWD="$(readlink -f $(dirname $0))"
OSVR_SERVER_CONFIG_DIR=${_PWD}/config

####################################
# DEVICES
####################################
_OPTS_DEVICES=""
for x in \
    /dev/dri/card* \
    /dev/loop* \
    /dev/nvidia* \
    /dev/snd/* \
    /dev/ttyACM* \
    /dev/ttyUSB* \
    /dev/video*
do
    test -c $x && test ! -L $x && _OPTS_DEVICES="$_OPTS_DEVICES --device=$x"
done
export _OPTS_DEVICES

${_PWD}/xlaunch.sh \
    --hostname osvr-server \
    --name osvr-server \
    --privileged \
    --publish 3883:3883/tcp \
    --publish 3883:3883/udp \
    --rm \
    -v ${OSVR_SERVER_CONFIG_DIR}:/opt/osvr/config \
    osvr/core:latest \
    osvr_server \
    ${@}
