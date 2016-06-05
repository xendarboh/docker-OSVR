Dockerized OSVR-WebVR
=====================

A docker image for [OSVR
WebVR](https://github.com/OSVR/OSVR-Docs/blob/master/Integrating-Game-Engines/WebVR/webvr.md)
that launches an instance of Firefox pre-configured for OSVR.

## Installation
1. build OSVR-Core docker image first

2. build
```bash
docker build -t osvr/webvr:latest OSVR-WebVR
```

3. run osvr_server if not already

4. launch Firefox to experience WebVR with OSVR!
```bash
bin/webvr
```

## Reference
* https://github.com/OSVR/OSVR-Docs/blob/master/Integrating-Game-Engines/WebVR/webvr.md
* https://hg.mozilla.org/integration/mozilla-inbound/rev/2da4c57f4595
* http://kb.mozillazine.org/Locking_preferences
