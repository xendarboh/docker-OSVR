FROM osvr/core:latest

ENV _UNITY_TAG=5.3.5f1+20160525

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget

# install unity
RUN cd /tmp \
    && wget "http://download.unity3d.com/download_unity/linux/unity-editor-${_UNITY_TAG}_amd64.deb" \
    && (dpkg -i /tmp/unity-editor-${_UNITY_TAG}_amd64.deb || apt-get -f install -y) \
    && rm unity-editor-${_UNITY_TAG}_amd64.deb

# install google chrome
RUN cd /tmp \
    && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
    && (dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y --no-install-recommends) \
    && rm google-chrome-stable_current_amd64.deb

# switch to user
ENV HOME=/home/${_USER} USER=${_USER} LC_ALL=${_LOCALE} LANG=${_LOCALE}
USER ${_USER}
WORKDIR /home/${_USER}

ENTRYPOINT ["/opt/Unity/Editor/Unity"]
