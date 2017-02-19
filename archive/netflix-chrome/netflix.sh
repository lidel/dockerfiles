#!/bin/bash
CHROME_DATA=/media/databank/var/netflix-chrome
IMAGE=netflix-chrome
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Build image if not present in docker
(docker images | grep -q $IMAGE) || docker build -t $IMAGE $DIR

# Enforce X11 access
xhost si:localuser:$USER

# Set up PulseAudio Cookie
if [ x"$(pax11publish -d)" = x ]; then
    start-pulseaudio-x11
fi

# Run ephemeral container with persisted chrome profile
exec docker run -i \
    --net host \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --volume="/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro" \
    -e DISPLAY=$DISPLAY \
    -v $CHROME_DATA:/data \
    -e PULSE_SERVER=tcp:localhost:4713 \
    -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
    --group-add audio \
    --group-add video \
    --user `id -u`:`getent group video | cut -d: -f3` \
    --device /dev/dri \
    --rm \
    $IMAGE
