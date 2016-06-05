FROM osvr/core:latest

ENV _OSVRTRACKERVIEW_TAG=master

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libopenscenegraph-dev \
    && rm -rf /var/lib/apt/lists/*

# Note: (as of 2016-06-04) "make install" just litters /usr/local: https://github.com/OSVR/OSVR-Tracker-Viewer/issues/5
#       so just use cp
RUN git clone \
        --branch ${_OSVRTRACKERVIEW_TAG} \
        --depth 1 \
        --recursive \
        https://github.com/OSVR/OSVR-Tracker-Viewer \
        /usr/local/src/osvr-tracker-viewer \
    && cd /usr/local/src/osvr-tracker-viewer \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make -j${_MAKE_JOBS} \
    && cp OSVRTrackerView /usr/local/bin/ \
    && rm -rf /usr/local/src/osvr-tracker-viewer
