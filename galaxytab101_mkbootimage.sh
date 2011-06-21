#!/bin/sh

set -x

# build ramdisk cpio.gz
rm -rf /tmp/initramfs-source
cp -ax samsung-initramfs-galaxytab101/working-copy /tmp/initramfs-source
find samsung-kernel-galaxytab101/ -name *.ko -exec cp -v {} /tmp/initramfs-source/lib/modules \;

cd /tmp/initramfs-source
find | grep -v .git | fakeroot cpio -o -H newc | gzip -9 > /tmp/initramfs-galaxytab101.cpio.gz
cd -

mkbootimg \
	--kernel samsung-kernel-galaxytab101/arch/arm/boot/zImage \
	--ramdisk /tmp/initramfs-galaxytab101.cpio.gz \
	-o /tmp/bootimage.img
