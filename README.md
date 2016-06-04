Dockerized OSVR
===============

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
* [https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md]
