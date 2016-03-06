FROM debian:stable
MAINTAINER Marcin Rataj <lidel@lidel.org>

ADD https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /src/google-chrome-stable_current_amd64.deb

# Install Chromium and PulseAudio with minimal dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    gconf-service \
    hicolor-icon-theme \
    libappindicator1 \
    libasound2 \
    libcanberra-gtk-module \
    libcurl3 \
    libexif-dev \
    libgconf-2-4 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libv4l-0 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    pulseaudio \
    fonts-liberation \
    wget \
    --no-install-recommends \
    && dpkg -i '/src/google-chrome-stable_current_amd64.deb' \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb \
    && echo "\n\
    pcm.pulse {\n\
        type pulse\n\
    }\n\
    ctl.pulse {\n\
        type pulse\n\
    }\n\
    pcm.!default {\n\
        type pulse\n\
    }\n\
    ctl.!default {\n\
        type pulse\n\
    }" > /etc/asound.conf \
    && echo "\
<?xml version='1.0'?>\
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>\
<fontconfig>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"rgba\">\
   <const>rgb</const>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"hinting\">\
   <bool>true</bool>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"hintstyle\">\
   <const>hintslight</const>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"antialias\">\
   <bool>true</bool>\
  </edit>\
 </match>\
  <match target=\"font\">\
    <edit mode=\"assign\" name=\"lcdfilter\">\
      <const>lcddefault</const>\
    </edit>\
  </match>\
</fontconfig>" > /etc/fonts/conf.d/99-netflix.conf \
    && echo "enable-shm = no" >> /etc/pulse/client.conf

ENV HOME /tmp

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data", "--no-sandbox", "--app=https://netflix.com" ]
