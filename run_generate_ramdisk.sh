#!/bin/sh

mkdir output 2>/dev/null

rm -rf output/ramdisk-voodoo/*

lagfix/voodoo_injector/generate_voodoo_ramdisk.sh \
	samsung_ramdisks/tmp-ramdisk-source/ \
	output/ramdisk-voodoo \
	lagfix/voodoo_ramdisk_parts
