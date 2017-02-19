FROM ubuntu:14.04

MAINTAINER Marcin Rataj <lidel@lidel.org>
LABEL evernote_wine=yes

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386

RUN apt-get update
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update
RUN apt-get install -y --no-install-recommends wine1.7 winetricks aria2
RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN groupadd -g 1042 evernote && \
#    useradd -r -u 1042 -g evernote -s /sbin/nologin --home-dir /evernote --create-home evernote

COPY evernote-wine.sh /evernote/evernote-wine.sh

RUN chown -R nobody:nobody /evernote && \
    chmod +x /evernote/evernote-wine.sh

USER nobody

ENV HOME /evernote
ENV WINEARCH win32
ENV WINEPREFIX $HOME/.wine
WORKDIR $HOME

RUN echo "echo 'Run: ./evernote-wine.sh'" >> $HOME/.bashrc

ENTRYPOINT ["/evernote/evernote-wine.sh"]
