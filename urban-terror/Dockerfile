FROM debian:stable-backports

MAINTAINER Marcin Rataj <lidel@lidel.org>
LABEL urban_terror=yes

ENV DEBIAN_FRONTEND noninteractive
ENV SDL_AUDIODRIVER pulse
ENV QT_X11_NO_MITSHM 1

# install deps and xorg-video driver
RUN apt-get update && apt-get -y install \
    libsdl1.2debian libxxf86vm1 libgl1-mesa-glx libgl1-mesa-dri \
    pulseaudio \
    libqtgui4 libqt4-network \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /urt && chmod 777 /urt

ENV HOME /urt
WORKDIR /urt/UrbanTerror42

ENTRYPOINT ["/urt/UrbanTerror42/Quake3-UrT.x86_64"]
