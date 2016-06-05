FROM osvr/core:latest

ENV _FIREFOX_TAG=49.0a1.en-US.linux-x86_64

# ppa:ubuntu-mozilla-daily/ppa -- Firefox Nightly build
# RUN add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends \
#         firefox-trunk
# && rm -rf /var/lib/apt/lists/*
#
#
RUN apt-get update \
     && apt-get install -y --no-install-recommends \
         wget
# && rm -rf /var/lib/apt/lists/*

RUN wget -qO - \
        "https://archive.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-${_FIREFOX_TAG}.tar.bz2" \
        | tar xvj -C /opt/

RUN apt-get install -y --no-install-recommends \
     libgtk-3-0



# create new user, grant sudo access
RUN useradd -m -s /bin/bash -u ${_USER_ID} -G ${_USER_GROUPS} ${_USER} \
  && echo "${_USER}:${_USER}" | chpasswd \
  && echo "${_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${_USER} \
  && chmod 0440 /etc/sudoers.d/${_USER}

# switch to user
ENV HOME=/home/${_USER} USER=${_USER} LC_ALL=${_LOCALE} LANG=${_LOCALE}
USER ${_USER}
WORKDIR /home/${_USER}
