#!/bin/bash

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

_PWD="$(readlink -f $(dirname $0))"
${_PWD}/xlaunch.sh \
    --hostname osvr \
    --name osvr \
    --privileged \
    --rm \
    osvr:latest \
    ${@}
