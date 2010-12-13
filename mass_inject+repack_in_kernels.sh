#!/bin/bash
echo "Mass voodoo injector+repacker"

mkdir -p kernel_injection/output/tarballs
mkdir -p kernel_injection/output/update_zips


my_generate_voodoo_initramfs()
{
	rm -rf /tmp/initramfs_with_voodoo_injected/*

	if test "$1" = 'no-builtin-cwm'; then
		lagfix/voodoo_injector/generate_voodoo_initramfs.sh \
			-s /tmp/initramfs_to_inject \
			-d /tmp/initramfs_with_voodoo_injected \
			-t lagfix/stages_builder/stages/ \
			-p lagfix/voodoo_initramfs_parts \
			-x lagfix/extensions -u
	elif test "$1" = 'full-lzma-loader'; then
		lagfix/voodoo_injector/generate_voodoo_initramfs.sh \
			-s /tmp/initramfs_to_inject \
			-d /tmp/initramfs_with_voodoo_injected \
			-t lagfix/stages_builder/stages/ \
			-p lagfix/voodoo_initramfs_parts \
			-c cwm/ \
			-x lagfix/extensions -l
	else
		lagfix/voodoo_injector/generate_voodoo_initramfs.sh \
			-s /tmp/initramfs_to_inject \
			-d /tmp/initramfs_with_voodoo_injected \
			-t lagfix/stages_builder/stages/ \
			-p lagfix/voodoo_initramfs_parts \
			-c cwm/ \
			-x lagfix/extensions -u
	fi
}

attempt_kernel_repack()
{
	echo -e "Compression mode: $compression\n"
	kernel_repack_utils/repacker.sh \
		-s $x \
		-r /tmp/initramfs_with_voodoo_injected/$1 \
		-c $compression \
		-d kernel_injection/output/$kernel_filename.zImage
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
		compression='lzma'
	else
		version='eclair'
		compression='gzip'
	fi

	rm -rf /tmp/initramfs_to_inject/*
	# extract the initramfs from the kernel
	kernel_repack_utils/extracter.sh -s "$x" -d /tmp/initramfs_to_inject

	cp -v ext4_modules/$version/*.ko /tmp/initramfs_to_inject/lib/modules

	my_generate_voodoo_initramfs

	if ! attempt_kernel_repack full-uncompressed; then
		# must be too big, let's try with a smaller voodoo initramfs configuration
		my_generate_voodoo_initramfs full-lzma-loader
		attempt_kernel_repack full-lzma-loader
	fi

	# build .tar archives for Odin
	cd kernel_injection/output
	cp -l $kernel_filename.zImage zImage
	tar cf tarballs/stock+Voodoo-$kernel_filename.tar zImage
	rm zImage
	cd - >/dev/null

	# build .tar archives for Odin
	update_zip/build_unsigned_update_zip.sh \
		-s kernel_injection/output/$kernel_filename.zImage \
		-d kernel_injection/output/update_zips/stock+Voodoo-$kernel_filename-unsigned-update.zip

done
