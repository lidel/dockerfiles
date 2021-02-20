FROM debian:stable

LABEL urban_terror=yes

ENV DEBIAN_FRONTEND noninteractive
ENV SDL_AUDIODRIVER pulse
ENV QT_X11_NO_MITSHM 1

# install deps and xorg-video driver
RUN apt-get update && apt-get -y install \
    libsdl-sound1.2 \
    libsdl1.2debian libxxf86vm1 libgl1-mesa-glx libgl1-mesa-dri \
    pulseaudio \
    curl \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /urt && chmod 777 /urt
    #libqtgui4 libqt4-network \

ENV HOME /urt
WORKDIR /urt/UrbanTerror

ENTRYPOINT ["/urt/UrbanTerror/Quake3-UrT.x86_64"]
