#!/bin/bash
CHROME_DATA=/media/databank/var/netflix-chrome
IMAGE=netflix-chrome
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Build image if not present in docker
(docker images | grep -q netflix-chrome) || docker build -t $IMAGE $DIR

# Enforce X11 access
xhost si:localuser:$USER

# Run ephemeral container with persisted chrome profile
exec docker run -it \
    --net host \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -v $CHROME_DATA:/data \
    -e PULSE_SERVER=tcp:localhost:4713 \
    -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
    --group-add audio \
    --group-add video \
    --device /dev/dri \
    --rm \
    $IMAGE
