#!/bin/sh

mkdir output 2>/dev/null

rm -rf output/ramdisk-voodoo/*

lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
	samsung_ramdisks/working-copy \
	output/ramdisk-voodoo \
	lagfix/voodoo_ramdisk_parts

# Stock ramdisk
#lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
#        samsung_ramdisks/froyo-xxjpm/ \
#        output/ramdisk-voodoo \
#        lagfix/voodoo_ramdisk_parts
