#!/bin/sh

mkdir -p output 2>/dev/null

rm -rf output/voodoo-initramfs/*

lagfix/voodoo_injector/generate_voodoo_initramfs.sh \
	-s samsung_initramfs/froyo-i9000xxjpy \
	-t lagfix/stages_builder/stages/ \
	-d output/voodoo-initramfs \
	-c cwm/ \
	-p lagfix/voodoo_initramfs_parts \
	-x lagfix/extensions -u -l

#rm -r output/multiboot
#lagfix/multiboot_injector/generate_multiboot_initramfs.sh \
#	samsung_initramfs/froyo-i9000xxjpo \
#	output/multiboot

