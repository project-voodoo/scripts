#!/bin/sh

./scripts/run_generate_initramfs.sh
./kernel_repack_utils/repacker.sh -s kernel_injection/source/Gingerbread-GT-I9000-XXJVB.zImage -d /tmp/ -r ~/dev/voodoo/output/voodoo-initramfs/full-lzma-loader -c gzip
adb reboot download && sleep 5
heimdall flash --kernel /tmp/zImage
