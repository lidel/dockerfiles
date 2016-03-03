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
    wget \
    xdg-utils \
    pulseaudio \
    fonts-liberation \
    --no-install-recommends \
    && dpkg -i '/src/google-chrome-stable_current_amd64.deb' \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb \
    && mkdir -p /home/chrome \
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
    }" > /home/chrome/.asoundrc \
    && echo "\
<?xml version='1.0'?>\
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>\
<fontconfig>\
 <match target="font">\
  <edit mode="assign" name="rgba">\
   <const>rgb</const>\
  </edit>\
 </match>\
 <match target="font">\
  <edit mode="assign" name="hinting">\
   <bool>true</bool>\
  </edit>\
 </match>\
 <match target="font">\
  <edit mode="assign" name="hintstyle">\
   <const>hintslight</const>\
  </edit>\
 </match>\
 <match target="font">\
  <edit mode="assign" name="antialias">\
   <bool>true</bool>\
  </edit>\
 </match>\
  <match target="font">\
    <edit mode="assign" name="lcdfilter">\
      <const>lcddefault</const>\
    </edit>\
  </match>\
</fontconfig>" > /home/chrome/.fonts.conf

# Disable shm as it does not work (known PA bug not fixed yet) under PID namespaces
RUN mkdir -p /home/chrome/.config/pulse \
    && echo "enable-shm = no" > /home/chrome/.config/pulse/client.conf

# Replace 1000 with your user / group id if necessary
RUN export uid=1000 gid=1000 && \
  echo "chrome:x:${uid}:${gid}:chrome,,,:/home/chrome:/bin/bash" >> /etc/passwd && \
  echo "chrome:x:${uid}:" >> /etc/group && \
  usermod -aG audio,video chrome && \
  chown -R chrome:chrome /home/chrome

USER chrome
ENV HOME /home/chrome

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data", "--no-sandbox", "--app=https://netflix.com" ]
