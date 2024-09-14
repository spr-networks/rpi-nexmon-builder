#!/bin/bash

# This script runs apt onto the mounted image,
# to download everything without needing `qemu`
#
/scripts/mount.sh

shopt -s expand_aliases

export DEBIAN_FRONTEND=noninteractive
# for host
#apt-get update
#apt-get install -y --no-install-recommends curl ca-certificates gpg git

sed -i 's/^Suites: noble$/Suites: noble noble-updates/' /mnt/fs//etc/apt/sources.list.d/ubuntu.sources

#for cross
STATE='-o Dir::Cache="/mnt/fs/var/cache/apt" -o Dir::State="/mnt/fs/var/lib/apt" -o Dir::Etc::Sourcelist="/mnt/fs/etc/apt/sources.list" -o Dir::Etc::Sourceparts="/mnt/fs/etc/apt/sources.list.d" -o Dir::State::Lists="/mnt/fs/var/lib/apt/lists" -o APT::Architecture="arm64" -o APT::Architectures="arm64"'
alias apty="apt-get $STATE"
apty update
apty install -y linux-headers-raspi
apty install -y linux-headers-raspi
apty install linux-image-raspi --download-only

SRC_VERSION=$(ls /usr/src | sed -n 's/.*-\([0-9.]\+-[0-9]\+\).*/\1/p' | head -n1)
VERSION=$(grep CONFIG_VERSION_SIGNATURE /mnt/fs/boot/config-*  | awk '{print $2}')
echo $VERSION > /VERSION
echo $VERSION
cp /mnt/fs/boot/config-${SRC_VERSION}-raspi /data/config-${VERSION}
cp /usr/src/linux-headers-${SRC_VERSION}-raspi/Module.symvers /data/Module-${VERSION}.symvers
