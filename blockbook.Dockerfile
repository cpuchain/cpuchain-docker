FROM ubuntu:jammy

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    ca-certificates \
    nano \
    wget \
    gpg \
    gpg-agent \
    aria2 \
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

RUN wget https://raw.githubusercontent.com/cpuchain/cpuchain/master/cpuchain.pgp && \
  echo "2d496aa22bac884f40c1e312ff1cb3d02c2a8b97b8dea17f66cf8414680a34af  cpuchain.pgp" | sha256sum -c && \
  gpg --import cpuchain.pgp && \
  aria2c -x 5 https://github.com/cpuchain/blockbook/releases/download/${BLOCKBOOK_VERSION}/backend-cpuchain_${VERSION}-satoshilabs-1_amd64.deb && \
  aria2c -x 5 https://github.com/cpuchain/blockbook/releases/download/${BLOCKBOOK_VERSION}/blockbook-cpuchain_${BLOCKBOOK_VERSION}_amd64.deb && \
  wget https://github.com/cpuchain/blockbook/releases/download/${BLOCKBOOK_VERSION}/SHA256SUMS.txt.asc && \
  gpg --output SHA256SUMS --verify SHA256SUMS.txt.asc && \
  sha256sum -c SHA256SUMS && \
  dpkg -i *.deb

RUN cp -r /opt/coins/blockbook/CPUchain/* .

ENTRYPOINT [ "/root/bin/blockbook" ]

EXPOSE 9190
EXPOSE 9090
