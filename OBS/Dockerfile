FROM osvr/core:latest

# ppa:kirillshkrogalev/ffmpeg-next -- latest ffmpeg
# ppa:obsproject/obs-studio        -- Open Broadcaster Software
RUN    add-apt-repository ppa:kirillshkrogalev/ffmpeg-next \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        obs-studio \
    && rm -rf /var/lib/apt/lists/*

# switch to user
ENV HOME=/home/${_USER} USER=${_USER} LC_ALL=${_LOCALE} LANG=${_LOCALE}
USER ${_USER}
WORKDIR /home/${_USER}
