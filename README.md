Dockerized OSVR
===============

This produces a docker image with the following installed:
* all OSVR dependencies as described in the [OSVR Linux Build Instructions](https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md)
* jsoncpp
* libfunctionality
* OSVR-Core

## Note
OpenGL is provided by nvidia, change the Dockerfile to match your system.

## Installation
1. edit Dockerfile
   * set \_NVIDIA\_VERSION to match the nvidia binary version of the host OS
   * optionally, set \_USER\_ID to match the userid on the host OS that you want to own created files

2. build
```bash
docker build -t osvr:latest .
```

3. run; mount volume for a home directory (to perserve your projects)
```bash
./xlaunch -v /home/myuser/OSVR:/home/osvr/ osvr:latest
```

## Reference
* https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md
* https://bitbucket.org/monkygames/osvr-core-ubuntu-build-script/src
