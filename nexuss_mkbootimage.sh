#!/bin/sh

set -x

# build ramdisk cpio.gz
cd nexuss-initramfs
find | grep -v .git | fakeroot cpio -o -H newc | gzip -9 > ../ns_out/initramfs.cpio.gz
cd ..

mkbootimg \
	--kernel /home/share/hardware/nexuss/kernel-from-dump/mtdblock2_boot.img-kernel \
	--ramdisk ns_out/initramfs.cpio.gz \
	--base 0x30000000 \
	--pagesize 4096 \
	--cmdline 'no_console_suspend=1 console=null' \
	-o ns_out/bootimage.img
