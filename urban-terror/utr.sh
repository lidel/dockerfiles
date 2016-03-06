#!/bin/bash
UTR_APP=$HOME/local/opt/UrbanTerror4.2
UTR_DATA=$HOME/.q3a
IMAGE=urban-terror
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Build image if not present in docker
(docker images | grep -q $IMAGE) || docker build -t $IMAGE $DIR

# Enforce X11 access
xhost si:localuser:$USER

# Run utr process in ephemeral container
function run {
    exec docker run -i \
        -v /etc/localtime:/etc/localtime:ro \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e PULSE_SERVER=tcp:localhost:4713 \
        -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
        --user `id -u`:`getent group video | cut -d: -f3` \
        --group-add games \
        --group-add audio \
        --group-add video \
        --net=host \
        --device /dev/dri \
        -v $UTR_APP:/urt/UrbanTerror42:ro \
        -v $UTR_DATA:/urt/.q3a:rw \
        --entrypoint="/urt/UrbanTerror42/${1}" \
        --rm --name utr-${1} $IMAGE
}

run Quake3-UrT.x86_64

#update:
#run UrTUpdater.x86_64
# with -v $UTR_APP:/urt/UrbanTerror42:rw
