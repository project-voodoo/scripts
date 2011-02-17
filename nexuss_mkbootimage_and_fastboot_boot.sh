#!/bin/sh

adb reboot bootloader
./scripts/nexuss_mkbootimage.sh
fastboot boot ns_out/bootimage.img
