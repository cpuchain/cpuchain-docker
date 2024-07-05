FROM ubuntu:jammy

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    ca-certificates \
    nano \
    libnorm1 \
    libpgm-5.3-0 \
    libsnappy1v5 \
    libzmq5 \
    psmisc \
    logrotate \
  && rm -rf /var/lib/apt/lists/*

ENV VERSION="25.2.1"
ENV BLOCKBOOK_VERSION="0.4.0"

WORKDIR /root

ADD build ./

RUN dpkg -i *.deb
