Dockerized OSVR-Unity
=====================

A docker image for launching Unity with OSVR development environment ala [OSVR
Unity](https://github.com/OSVR/OSVR-Unity).

## Installation
1. build OSVR-Core docker image first

2. build

    ```bash
    docker build -t osvr/unity:latest OSVR-Unity
    ```

3. run osvr_server if not already

4. start

    ```bash
    bin/unity
    ```

## Reference
* http://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/
* https://github.com/tomwillfixit/unity3d/blob/master/Dockerfile
