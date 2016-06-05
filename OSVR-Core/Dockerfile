# reference: https://github.com/OSVR/OSVR-Docs/blob/master/Getting-Started/Installing/Linux-Build-Instructions.md
FROM ubuntu:trusty-20160526

# configuration
ENV _LOCALE=en_US.UTF-8
ENV _MAKE_JOBS=8
ENV _USER=x
ENV _USER_GROUPS=audio,video
ENV _USER_ID=1000

# versions
ENV _BOOST_VERSION=1.55
ENV _JSONCPP_TAG=master
ENV _LIBFUNCTIONALITY_TAG=master
ENV _NVIDIA_VERSION=352
ENV _OSVR_TAG=master

ENV DEBIAN_FRONTEND noninteractive

# set locale
RUN locale-gen ${_LOCALE} \
  && update-locale LANG=${_LOCALE} LC_ALL=${_LOCALE}

# multiverse                    -- nvidia-cg and others
# ppa:george-edison55/cmake-3.x -- CMake 3.0 or newer
# ppa:ubuntu-toolchain-r/test   -- gcc-5
# ppa:xorg-edgers               -- nvidia drivers
# x11-xserver-utils             -- provides /usr/bin/xrandr
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y multiverse \
    && add-apt-repository -y ppa:george-edison55/cmake-3.x \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && add-apt-repository -y ppa:xorg-edgers/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        cmake \
        g++-5 \
        gcc-5 \
        git \
        libboost${_BOOST_VERSION}-dev \
        libboost-filesystem${_BOOST_VERSION}-dev \
        libboost-program-options${_BOOST_VERSION}-dev \
        libboost-thread${_BOOST_VERSION}-dev \
        libcuda1-${_NVIDIA_VERSION} \
        libopencv-dev \
        libsdl2-dev \
        libusb-1.0-0-dev \
        nvidia-${_NVIDIA_VERSION} \
        nvidia-cg-toolkit \
        nvidia-libopencl1-${_NVIDIA_VERSION} \
        nvidia-opencl-icd-${_NVIDIA_VERSION} \
        x11-xserver-utils \
        xdg-user-dirs \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 50 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 50 \
    && rm -rf /var/lib/apt/lists/*

# install latest libfunctionality from source
RUN git clone \
        --branch ${_LIBFUNCTIONALITY_TAG} \
        --depth 1 \
        https://github.com/OSVR/libfunctionality \
        /usr/local/src/libfunctionality \
    && cd /usr/local/src/libfunctionality \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make -j${_MAKE_JOBS} \
    && make install \
    && rm -rf /usr/local/src/libfunctionality

# install latest jsoncpp
RUN git clone \
        --branch ${_JSONCPP_TAG} \
        --depth 1 \
        --recursive \
        https://github.com/VRPN/jsoncpp \
        /usr/local/src/jsoncpp \
    && cd /usr/local/src/jsoncpp \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DCMAKE_CXX_FLAGS=-fPIC \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DJSONCPP_LIB_BUILD_SHARED=OFF \
        -DJSONCPP_WITH_CMAKE_PACKAGE=ON \
    && make -j${_MAKE_JOBS} \
    && make install \
    && rm -rf /usr/local/src/jsoncpp

# install latest OSVR-Core from the master branch
# Note: make jobs are set to 1 to avoid this type of docker build failure:
#       apparmor="DENIED" operation="file_mmap" profile="docker-default" name="d/usr/include/x86_64-linux-gnu/bits/wordsize.h" pid=30713 comm="cmake" requested_mask="mr" denied_mask="mr" fsuid=0 ouid=0
RUN git clone \
        --branch ${_OSVR_TAG} \
        --depth 1 \
        --recursive \
        https://github.com/OSVR/OSVR-Core \
        /usr/local/src/osvr-core \
    && cd /usr/local/src/osvr-core \
    && mkdir build \
    && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make -j1 \
    && make install \
    && rm -rf /usr/local/src/osvr-core


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

WORKDIR /opt/osvr
