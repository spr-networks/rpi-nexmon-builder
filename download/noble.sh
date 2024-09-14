#!/bin/sh
set -e
VERSION="24.04.1"
IMG="ubuntu-${VERSION}-preinstalled-server-arm64+raspi.img.xz"

cd ./data
if [ ! -f $IMG ]; then
  wget -q "https://cdimage.ubuntu.com/releases/${VERSION}/release/${IMG}"
fi

xzcat $IMG > base.img


echo "[+] Extracted pi arm64 ubuntu image"

#docker run --privileged -v /dev:/dev -v $PWD/data:/data -v $PWD/scripts:/scripts/ ubuntu:24.04 /scripts/go-pi.sh


#cp /scripts/pi-target-install.sh /mnt/fs/pi-target-install.sh

#/scripts/mount.sh

#qemu-system-aarch64 -machine virt -cpu cortex-a72 -smp 2 -m 1G -initrd initrd -kernel vmlinuz -append "root=/dev/vda2 rootfstype=ext4 rw panic=0 net.ifnames=0 biosdevname=0 init=/pi-target-install.sh"   -drive file=base.img,format=raw,if=none,id=hd0 -device virtio-blk-pci,drive=hd0  -netdev user,id=mynet -device virtio-net-pci,netdev=mynet -nographic
