FROM phusion/baseimage:0.9.17

MAINTAINER Marcin Rataj <lidel@lidel.org>
LABEL urban_terror=yes

ENV DEBIAN_FRONTEND noninteractive
ENV SDL_AUDIODRIVER pulse
ENV QT_X11_NO_MITSHM 1

ENV USR_UID=$(id -u)
ENV GAMES_GID=$(grep '^games:' /etc/group | cut -d: -f3)
ENV AUDIO_GID=$(grep '^audio:' /etc/group | cut -d: -f3)
ENV VIDEO_GID=$(grep '^video:' /etc/group | cut -d: -f3)

# Install zip and aria2
RUN apt-get update && apt-get -y install unzip aria2 libsdl1.2debian libxxf86vm1 libgl1-mesa-glx libgl1-mesa-dri pulseaudio libqtgui4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Create a urt user with premissions matching host system
RUN (grep :\$GAMES_GID: /etc/group -q || groupadd -g \$GAMES_GID games_urt) && \
    (grep :\$AUDIO_GID: /etc/group -q || groupadd -g \$AUDIO_GID audio_urt) && \
    (grep :\$VIDEO_GID: /etc/group -q || groupadd -g \$VIDEO_GID video_urt) && \
    useradd -G \$AUDIO_GID,\$VIDEO_GID -u \$USR_UID -g \$GAMES_GID --home-dir /home/urt --create-home urt

WORKDIR /home/urt/UrbanTerror42

USER urt

ENTRYPOINT ["/home/urt/UrbanTerror42/Quake3-UrT.x86_64"]
