Dockerized OSVR
===============

A collection of Dockerfiles to dockerize OSVR, including:
* [OSVR-Core](OSVR-Core/README.md)
* [OSVR-Tracker-Viewer](OSVR-Tracker-Viewer/README.md)
* [OSVR-WebVR](OSVR-WebVR/README.md)

## TODO
- [ ] osvr_server Dockerfile for the specific purpose of running osvr_server
- [ ] remove --privileged from osvr_server.sh, determine specifically which devices are needed
- [ ] remove nvidia/opengl from OSVR-Core if it is not needed
- [x] install OSVR Tracker Viewer, after tested extract to its own Dockerfile
- [x] fix error: `D-Bus ... Failed to open "/etc/machine-id"`
- [ ] WebVR: save firefox configuration to enable osvr
- [ ] seperate osvr/server image from osvr/core


## Note
OpenGL is provided by nvidia, change the Dockerfile to match your host.

## Host Setup
(optional) Install udev rules for OSVR HDK group permissions (plugdev) and
device symlink (/dev/ttyUSB.OSVRHDK), restart udev to make changes live.
```bash
sudo cp 99-osvr.rules /etc/udev/rules.d/
sudo /etc/init.d/udev restart
```

## Installation
1. edit OSVR-Core/Dockerfile
   * set \_NVIDIA\_VERSION to match the nvidia binary version of the host OS
   * optionally, set \_USER\_ID to match the userid on the host OS that you want to own created files

2. build
```bash
docker build -t osvr/core:latest OSVR-Core
```

3. configure: place your osvr_server configuration files in the config/ directory

4. run
```bash
bin/osvr_server.sh config/<your_osvr_server_config>.json
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
