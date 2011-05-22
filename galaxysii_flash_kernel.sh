#!/bin/sh

cd samsung-kernel-galaxysii/arch/arm/boot
ls -lh zImage
if ! adb push zImage /sdcard/dev/block/mmcblk0p5; then
	adb push zImage /sdcard/
	adb shell su -c "cat /sdcard/zImage > /dev/block/mmcblk0p5"
fi

if test -n "$1"; then
	adb shell "sync; reboot"
fi
