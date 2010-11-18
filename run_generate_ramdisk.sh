#!/bin/sh

mkdir output 2>/dev/null

rm -r output/ramdisk-voodoo/*

lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
	samsung_ramdisks/working-copy \
	output/ramdisk-voodoo \
	lagfix/voodoo_ramdisk_parts

rm -r output/multiboot
lagfix/multiboot_injector/generate_multiboot_ramdisk.sh \
	samsung_ramdisks/froyo-i9000xxjpo \
	output/multiboot

# Stock ramdisk
#lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
#        samsung_ramdisks/froyo-xxjpm/ \
#        output/ramdisk-voodoo \
#        lagfix/voodoo_ramdisk_parts
