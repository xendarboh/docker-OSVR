# reference: https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md
FROM ubuntu:trusty-20160526

# configuration
ENV _LOCALE=en_US.UTF-8
ENV _USER=x
ENV _USER_GROUPS=audio,video
ENV _USER_ID=1000
ENV _JOBS=8

ENV DEBIAN_FRONTEND noninteractive

# set locale
RUN locale-gen ${_LOCALE} \
  && update-locale LANG=${_LOCALE} LC_ALL=${_LOCALE}

# ppa:george-edison55/cmake-3.x -- CMake 3.0 or newer
RUN apt-get update

RUN apt-get install -y software-properties-common \
    && add-apt-repository ppa:george-edison55/cmake-3.x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git

ENV _BOOST_VERSION=1.55
RUN apt-get install -y --no-install-recommends \
        clang-3.6 \
        libboost-filesystem${_BOOST_VERSION}-dev \
        libboost-program-options${_BOOST_VERSION}-dev \
        libboost-thread${_BOOST_VERSION}-dev \
        libboost${_BOOST_VERSION}-dev \
        libopencv-dev \
        libusb-dev

# install latest libfunctionality from source
ENV _LIBFUNCTIONALITY_TAG=master
RUN git clone \
        --branch ${_LIBFUNCTIONALITY_TAG} \
        --depth 1 \
        https://github.com/OSVR/libfunctionality \
        /usr/local/src/libfunctionality \
    && cd /usr/local/src/libfunctionality \
    && mkdir build \
    && cd build \
    && cmake \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        ../ \
    && make -j${_JOBS} \
    && make install \
    && rm -rf /usr/local/src/libfunctionality


# install latest jsoncpp
ENV _JSONCPP_TAG=master
RUN git clone \
        --recursive \
        --branch ${_JSONCPP_TAG} \
        --depth 1 \
        https://github.com/VRPN/jsoncpp \
        /usr/local/src/jsoncpp \
    && cd /usr/local/src/jsoncpp \
    && mkdir build \
    && cd build \
    && cmake \
        -D CMAKE_CXX_FLAGS=-fPIC \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D JSONCPP_LIB_BUILD_SHARED=OFF \
        -D JSONCPP_WITH_CMAKE_PACKAGE=ON \
        ../ \
    && make -j${_JOBS} \
    && make install \
    && rm -rf /usr/local/src/jsoncpp

# install latest OSVR-Core from the master branch
ENV _OSVR_TAG=master
RUN git clone \
        --recursive \
        --branch ${_OSVR_TAG} \
        --depth 1 \
        https://github.com/OSVR/OSVR-Core \
        /usr/local/src/osvr-core

# :TODO: replace the libusb above with this:
RUN apt-get install -y --no-install-recommends \
    libusb-1.0-0-dev

RUN apt-get install -y --no-install-recommends \
    libsdl2-dev

ENV _NVIDIA_VERSION=352
# xorg-edgers/ppa     -- nvidia drivers
# multiverse          -- nvidia-cg and others
# x11-xserver-utils   -- provides /usr/bin/xrandr
RUN \
    add-apt-repository -y ppa:xorg-edgers/ppa \
    && add-apt-repository -y multiverse \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libcuda1-${_NVIDIA_VERSION} \
        nvidia-${_NVIDIA_VERSION} \
        nvidia-cg-toolkit \
        nvidia-libopencl1-${_NVIDIA_VERSION} \
        nvidia-opencl-icd-${_NVIDIA_VERSION} \
        x11-xserver-utils \
        xdg-user-dirs

# Note: make jobs are set to 1 to avoid this type of failure:
#       apparmor="DENIED" operation="file_mmap" profile="docker-default" name="d/usr/include/x86_64-linux-gnu/bits/wordsize.h" pid=30713 comm="cmake" requested_mask="mr" denied_mask="mr" fsuid=0 ouid=0
RUN cd /usr/local/src/osvr-core \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make -j1 \
    && make install \
    && rm -rf /usr/local/src/osvr-core

#:    && rm -rf /var/lib/apt/lists/*
#:
#:  # create new user, grant sudo access
#:  RUN useradd -m -s /bin/bash -u ${_USER_ID} -G ${_USER_GROUPS} ${_USER} \
#:    && echo "${_USER}:${_USER}" | chpasswd \
#:    && echo "${_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${_USER} \
#:    && chmod 0440 /etc/sudoers.d/${_USER}
#:
#:  # switch to user
#:  ENV HOME=/home/${_USER} USER=${_USER} LC_ALL=${_LOCALE} LANG=${_LOCALE}
#:  USER ${_USER}
#:  WORKDIR /home/${_USER}
