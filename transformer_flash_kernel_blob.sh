#!/bin/sh

adb push transformer_blobs/custom/custom-kernel.blob /sdcard/
adb shell su -c "cat /sdcard/custom-kernel.blob > /dev/block/mmcblk0p4"
adb shell sync
adb reboot
