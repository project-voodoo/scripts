#!/bin/sh

mkdir -p output 2>/dev/null

rm -rf output/ramdisk-voodoo/*

lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
	-s samsung_ramdisks/working-copy \
	-d output/ramdisk-voodoo \
	-p lagfix/voodoo_ramdisk_parts \
	-x lagfix/extensions -u

#rm -r output/multiboot
#lagfix/multiboot_injector/generate_multiboot_ramdisk.sh \
#	samsung_ramdisks/froyo-i9000xxjpo \
#	output/multiboot

# Stock ramdisk
#lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
#        samsung_ramdisks/froyo-xxjpm/ \
#        output/ramdisk-voodoo \
#        lagfix/voodoo_ramdisk_parts
