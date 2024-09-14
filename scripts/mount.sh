#!/bin/bash
IMG="/data/base.img"

mkdir /mnt/fs
s=$(fdisk -l ${IMG}  | grep img2 | awk '{print $2}')
mount -o loop,offset=$[512*${s}] ${IMG} /mnt/fs



#if [ ! -f /data/vmlinuz ]; then
#   mkdir /mnt/image
#   mount -o loop,offset=1048576 base.img /mnt/image
#   cp /mnt/image/vmlinuz /data/vmlinuz
#   cp /mnt/image/initrd.img /data/initrd.img
#fi
