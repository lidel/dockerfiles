#!/bin/bash
UTR_VER="434"
UTR_APP=$HOME/local/opt/UrbanTerror${UTR_VER}
UTR_DATA=$HOME/.q3a
IMAGE=urban-terror${UTR_VER}
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Build image if not present in docker
(docker images | grep -q $IMAGE) || docker build -t $IMAGE $DIR

# Enforce X11 access
xhost si:localuser:$USER

# Set up PulseAudio Cookie
if [ x"$(pax11publish -d)" = x ]; then
    start-pulseaudio-x11
fi

# Run utr process in ephemeral container
function run {
    docker run -i \
        -v /etc/localtime:/etc/localtime:ro \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/asound.conf:/etc/asound.conf:ro \
        -e SDL_AUDIODRIVER=pulse \
        -e PULSE_SERVER=tcp:localhost:4713 \
        -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
        --user `id -u`:`getent group video | cut -d: -f3` \
        --group-add games \
        --group-add audio \
        --group-add video \
        --net=host \
        --device /dev/dri \
        -v $UTR_APP:/urt/UrbanTerror:ro \
        -v $UTR_DATA:/urt/.q3a:rw \
        --entrypoint="/urt/UrbanTerror/${1}" \
        --rm --name utr${UTR_VER}-${1} $IMAGE
}

run Quake3-UrT.x86_64
