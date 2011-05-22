#!/bin/sh

cd samsung-kernel-galaxysii/arch/arm/boot
ls -lh zImage

adb push zImage /data/local/tmp
adb shell su -c "cat /data/local/tmp/zImage > /dev/block/mmcblk0p5"

if test -n "$1"; then
	adb shell "sync; reboot"
fi
