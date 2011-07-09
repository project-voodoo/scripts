#!/bin/sh

./scripts/lg2x_build_mkbootimage.sh
adb push /tmp/bootimage.img /data/local/tmp && \
	adb shell "su -c 'cat /data/local/tmp/bootimage.img > /dev/block/mmcblk0p5'"
