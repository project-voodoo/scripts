#!/bin/sh

adb reboot bootloader
./scripts/galaxytab101_mkbootimage.sh
fastboot boot /tmp/bootimage.img
