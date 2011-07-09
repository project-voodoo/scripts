#!/bin/sh

set -x

# build ramdisk cpio.gz
rm -rf /tmp/initramfs-source
cp -ax lg2x-initramfs/working-copy/ /tmp/initramfs-source
adb shell "su -c 'mount -o remount,rw /system /system'"
adb shell "mkdir /data/local/tmp/kmods"
find linux_lge-p990/ -name *.ko -exec adb push {} /data/local/tmp/kmods/ \;
adb shell "su -c '/data/local/busybox cp /data/local/tmp/kmods/*.ko /system/lib/modules'"
adb shell sync

cd /tmp/initramfs-source
find | grep -v .git | fakeroot cpio -o -H newc | gzip -9 > /tmp/initramfs-lge-p990.cpio.gz
cd -

mkbootimg \
	--kernel linux_lge-p990/arch/arm/boot/zImage \
	--ramdisk /tmp/initramfs-lge-p990.cpio.gz \
	-o /tmp/bootimage.img
