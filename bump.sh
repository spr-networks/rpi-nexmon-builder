#!/bin/bash
docker build -f download/Dockerfile-noble . -t updater
docker run --name updated --privileged -it updater /scripts/pi-cross-update.sh
docker cp updated:/VERSION /tmp/
VERSION=$(cat /tmp/VERSION)
docker cp updated:/data/config-${VERSION} configs/
docker cp updated:/data/Module-${VERSION}.symvers symvers/
