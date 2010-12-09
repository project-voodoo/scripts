#!/bin/bash

echo "Mass voodoo injector+repacker"

scripts/run_generate_ramdisk.sh || exit 1


echo "Now process kernels_to_inject directory"

test -d kernels_to_inject || exit 1
mkdir -p kernels_injected/tarballs

for x in kernels_to_inject/*.zImage; do
	test -f "$x" || return
	echo -e "\n$x"
	kernel_filename=`basename $x .zImage`


	if test "`echo $kernel_filename | grep -i eclair`" = ""; then
		compression='lzma'
	else
		compression='gzip'
	fi

	echo -e "Compression mode: $compression\n"

	kernel_repack_utils/repacker.sh \
		-s $x \
		-r output/ramdisk-voodoo/uncompressed\
		-c $compression \
		-d kernels_injected/$kernel_filename.zImage

	# build .tar archives for Odin
	cd kernels_injected/
	cp -l $kernel_filename.zImage zImage
	tar cvf tarballs/stock+Voodoo-$kernel_filename.tar zImage
	rm zImage
	cd - >/dev/null
done
