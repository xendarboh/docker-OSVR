Dockerized OSVR-WebVR
=====================

Builds a docker image for [OSVR WebVR](https://github.com/OSVR/OSVR-Docs/blob/master/Integrating-Game-Engines/WebVR/webvr.md).

## Installation
1. build OSVR-Core docker image first

2. build
```bash
docker build -t osvr/webvr:latest OSVR-WebVR
```

3. run
```bash
bin/webvr
```

## Reference
* https://github.com/OSVR/OSVR-Docs/blob/master/Integrating-Game-Engines/WebVR/webvr.md
* https://hg.mozilla.org/integration/mozilla-inbound/rev/2da4c57f4595
