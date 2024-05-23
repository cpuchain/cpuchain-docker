#!/bin/bash

VERSION="25.2.1"

if [ ! -d /root/.cpuchain/blocks ]; then
  echo "Initing chain directory"

  mkdir /root/.cpuchain

  7z x cpuchain-$VERSION/CPUchain-IBD.7z && \
    mv CPUchain/* /root/.cpuchain
fi

exec cpuchaind "$@"