# Dockerfiles
Dockerized versions of various games and apps.

## PulseAudio Sound

Some of containerized apps use PulseAudio network streaming with cookie authentication.

Network streaming requires `load-module module-native-protocol-tcp` to be present in PA config (eg. `/etc/pulse/default.pa`).

Cookie is read from X11 root attribute (set by `start-pulseaudio-x11`).
