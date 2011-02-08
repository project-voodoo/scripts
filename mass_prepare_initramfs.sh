#!/bin/bash
echo "Mass Voodoo prepare initramfs"

# change it for your configuration
output_dir=/home/share/voodoo-dl/precompiled/voodoo-initramfs
mkdir -p $output_dir


my_generate_voodoo_initramfs()
{
	rm -rf $output_dir/$kernel_filename

	lagfix/voodoo_injector/generate_voodoo_initramfs.sh \
		-s /tmp/initramfs_to_inject \
		-d $output_dir/$kernel_filename \
		-t lagfix/stages_builder/stages/ \
		-p lagfix/voodoo_initramfs_parts \
		-c cwm/ \
		-x lagfix/extensions -u -l
	# some cleanup
	rm -r $output_dir/$kernel_filename/*.cpio
	rm -r $output_dir/$kernel_filename/reference
	rm -r $output_dir/$kernel_filename/full-uncompressed
	rm -r $output_dir/$kernel_filename/full-lzma-loader
	rm -r $output_dir/$kernel_filename/sdcard-*
}

if test -n "$1"; then
	zImage_list=$*
else
	zImage_list=kernel_injection/source/*.zImage
fi

for x in $zImage_list; do
	test -f "$x" || return
	echo -e "\n\n\n$x\n"

	kernel_filename=`basename $x .zImage`
	# choose compression mode automatically based on the filename
	if test "`echo $kernel_filename | grep -i eclair`" = ""; then
		version='froyo'
	else
		version='eclair'
	fi

	rm -rf /tmp/initramfs_to_inject/*
	# extract the initramfs from the kernel
	kernel_repack_utils/extracter.sh -s "$x" -d /tmp/initramfs_to_inject

	my_generate_voodoo_initramfs

done
