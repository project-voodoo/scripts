#!/bin/sh


./scripts/nexuss_mkbootimage.sh
adb reboot bootloader
fastboot boot ns_out/bootimage.img
