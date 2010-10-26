#!/bin/sh
adb push scripts/redbend_ua /sdcard/
adb push linux_gt-i9000/zImage /sdcard/

adb shell su -c "cat /sdcard/redbend_ua > /data/redbend_ua"
adb shell su -c "chmod 755 /data/redbend_ua"
adb shell su -c "/data/redbend_ua restore /sdcard/zImage /dev/block/bml7"
