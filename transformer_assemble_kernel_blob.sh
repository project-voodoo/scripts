#!/bin/sh

BOOTIMG="/tmp/transformer-LNX.img"
SOURCE_BLOB="transformer_blobs/WW_epad-user-8.2.3.9/blob"
OUTPUT_DIR="transformer_blobs/custom"

mkbootimg \
	--kernel linux_transformer/arch/arm/boot/zImage \
	--ramdisk $SOURCE_BLOB.LNX-ramdisk.cpio.gz \
	-o $BOOTIMG

mkdir -p $OUTPUT_DIR
blobpack $SOURCE_BLOB.HEADER $OUTPUT_DIR/custom-kernel.blob LNX $BOOTIMG
