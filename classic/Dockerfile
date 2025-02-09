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
    p7zip-full \
  && rm -rf /var/lib/apt/lists/*

ENV VERSION="25.2.1"
ENV TORRENT="magnet:?xt=urn:btih:2E45FCD87A864766E8A9382A1F5E1F9026877354&dn=cpuchain-25.2.1&tr=udp%3a%2f%2ftracker.opentrackr.org%3a1337%2fannounce&tr=https%3a%2f%2ftracker1.ctix.cn%3a443%2fannounce&tr=udp%3a%2f%2fopen.demonii.com%3a1337%2fannounce&tr=udp%3a%2f%2fopen.stealth.si%3a80%2fannounce&tr=udp%3a%2f%2ftracker.torrent.eu.org%3a451%2fannounce&tr=https%3a%2f%2ftracker.loligirl.cn%3a443%2fannounce&tr=udp%3a%2f%2ftracker-udp.gbitt.info%3a80%2fannounce&tr=udp%3a%2f%2fexplodie.org%3a6969%2fannounce&tr=udp%3a%2f%2fexodus.desync.com%3a6969%2fannounce&tr=https%3a%2f%2ftracker.gbitt.info%3a443%2fannounce&tr=udp%3a%2f%2ftracker.tiny-vps.com%3a6969%2fannounce&tr=udp%3a%2f%2ftracker.0x7c0.com%3a6969%2fannounce&tr=udp%3a%2f%2frun.publictracker.xyz%3a6969%2fannounce&tr=udp%3a%2f%2fopentracker.io%3a6969%2fannounce&tr=udp%3a%2f%2foh.fuuuuuck.com%3a6969%2fannounce&tr=udp%3a%2f%2fmoonburrow.club%3a6969"

WORKDIR /root

RUN wget https://raw.githubusercontent.com/cpuchain/cpuchain/master/cpuchain.pgp && \
  echo "2d496aa22bac884f40c1e312ff1cb3d02c2a8b97b8dea17f66cf8414680a34af  cpuchain.pgp" | sha256sum -c && \
  gpg --import cpuchain.pgp && \
  aria2c --enable-dht=true --seed-time=0 $TORRENT && \
  cd cpuchain-$VERSION && \
  gpg --output SHA256SUMS --verify SHA256SUMS.txt.asc && \
  sha256sum -c SHA256SUMS && \
  tar -xvf cpuchain-$VERSION-x86_64-linux-gnu.tar.gz && \
  mv cpuchain-$VERSION/bin/* /usr/local/bin && rm -r cpuchain-$VERSION && cd ..

ADD cpuchain.sh .

ENTRYPOINT [ "./cpuchain.sh" ]

EXPOSE 19706
EXPOSE 19707
EXPOSE 19708
EXPOSE 29000