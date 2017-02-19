FROM ubuntu:14.04

MAINTAINER Marcin Rataj <lidel@lidel.org>
LABEL base_wine=yes

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386

RUN apt-get update
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update
RUN apt-get install -y --no-install-recommends wine1.7 winetricks xvfb
RUN apt-get purge -y software-properties-common
RUN apt-get clean -y

