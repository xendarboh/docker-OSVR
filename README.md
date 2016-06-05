Dockerized OSVR
===============

This produces a docker image with the following installed:
* all OSVR dependencies as described in the [OSVR Linux Build
  Instructions](https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md)
* jsoncpp
* libfunctionality
* OSVR-Core

## Note
OpenGL is provided by nvidia, change the Dockerfile to match your system.

## Host Setup
(optional) Install udev rules for OSVR HDK group permissions (plugdev) and
device symlink (/dev/ttyUSB.OSVRHDK), restart udev to make changes live.
```bash
sudo cp 99-osvr.rules /etc/udev/rules.d/
sudo /etc/init.d/udev restart
```

## Installation
1. edit Dockerfile
   * set \_NVIDIA\_VERSION to match the nvidia binary version of the host OS
   * optionally, set \_USER\_ID to match the userid on the host OS that you want to own created files

2. build
```bash
docker build -t osvr/core:latest .
```

3. configure: place your osvr_server configuration files in the config/ directory

4. run
```bash
./osvr_server.sh config/<your_osvr_server_config>.json
```

## Reference
* https://github.com/OSVR/OSVR-Core/blob/master/doc/Building.md
* https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md
* https://bitbucket.org/monkygames/osvr-core-ubuntu-build-script/src
* https://github.com/OSVR/OSVR-Docs/blob/master/Configuring/osvrhdk.md
* https://github.com/OSVR/OSVR-JSON-Schemas/blob/master/osvr_server_config_schema.json


# Other Information

* to check the firmware version of the IR camera
```bash
lsusb -v -d 0bda:57e8 | grep bcdDevice
```

* video has to be sent to the HMD in order for OSVRTrackerViewer to register display
```
[TrackerViewer] /me/head - got first report, enabling display!
```

* the environment variable OSVR_HOST is used to set the location of the osvr_server if not the default `localhost:3883`
