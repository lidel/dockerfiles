#!/bin/env bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
IMAGE=zoom-us-lidel
ZOOM_US_USER=$USER
DOWNLOAD_DIR="${HOME}/Downloads"

# Build image if not present in docker
(docker images | grep -q $IMAGE) || docker build -t $IMAGE $DIR

mkdir -p ${HOME}/.zoom
mkdir -p $DOWNLOAD_DIR

# enumerate video devices for webcam support
VIDEO_DEVICES=
for device in /dev/video*
do
	if [ -c $device ]; then
		VIDEO_DEVICES="${VIDEO_DEVICES} --device $device:$device"
	fi
done

echo "Starting ${prog}..."
docker run -i --rm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  --device /dev/dri \
  -e ZOOM_US_USER=$ZOOM_US_USER \
  -e USER_UID=$(id -u) \
  -e USER_GID=$(id -g) \
  -v ${DOWNLOAD_DIR}:/home/${ZOOM_US_USER}/Download \
  -v ${HOME}/.config:/home/${ZOOM_US_USER}/.config \
  -v ${HOME}/.zoom:/home/${ZOOM_US_USER}/.zoom \
  ${VIDEO_DEVICES} \
  -e PULSE_SERVER=tcp:localhost:4713 \
  -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
  --net=host \
  ${IMAGE}:latest zoom $@
