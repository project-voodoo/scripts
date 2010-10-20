#!/bin/sh
adb push scripts/redbend_ua /sdcard/
adb push linux_gt-i9000/zImage /sdcard/

adb shell su -c "/system/xbin/busybox mv /sdcard/redbend_ua /data/"
adb shell su -c "/data/redbend_ua restore /sdcard/zImage /dev/block/bml7"
