Dockerized OSVR-Tracker-Viewer
==============================

Builds a docker image for [OSVR Tracker
Viewer](https://github.com/OSVR/OSVR-Tracker-Viewer).

## Installation
1. build OSVR-Core docker image first

2. build
```bash
docker build -t osvr/tracker-viewer:latest .
```

3. run
```bash
./OSVRTrackerViewer.sh
```
