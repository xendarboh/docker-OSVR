Dockerized Open Broadcaster Software
====================================

A docker image for [Open Broadcaster Software](https://obsproject.com/) for use
in the context of mirroring the screen of an HMD.  It is useful when hardware
mirroring is not desired or available.

## Installation
1. build

    ```bash
    docker build -t osvr/obs:latest OBS
    ```

2. run

    ```bash
    bin/obs
    ```

## osb settings recommendations
| Name                 | Value     |
| -------------------- | --------- |
| Encoder              | x264      |
| Max Bitrate (kb/s)   | 1000      |
| Resolution Downscale | 852 x 480 |
| FPS                  | 15        |

## Reference
* http://wiki.osvr.com/doku.php?id=obsproject
* https://obsproject.com/download#linux
