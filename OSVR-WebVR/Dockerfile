FROM osvr/core:latest

ENV _FIREFOX_TAG=49.0a1.en-US.linux-x86_64

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        dbus \
        libgtk-3-0 \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO - \
        "https://archive.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-${_FIREFOX_TAG}.tar.bz2" \
        | tar xvj -C /opt/

# set firefox default prefs to enable and configure OSVR
ADD mozilla.cfg /opt/firefox/
ADD local-settings.js /opt/firefox/defaults/pref/

# fix D-bus warnings from firefox
RUN dbus-uuidgen > /etc/machine-id

# switch to user
ENV HOME=/home/${_USER} USER=${_USER} LC_ALL=${_LOCALE} LANG=${_LOCALE}
USER ${_USER}
WORKDIR /home/${_USER}
