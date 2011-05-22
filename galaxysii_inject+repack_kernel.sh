#!/bin/bash
echo "Galaxy S II injector+repacker"

if test -f $1; then
	x=$1
	mkdir -p /tmp/repacker
	DEST="galaxysii-stock+root.tar"
else
	echo "please specify zImage intput"
	exit 1
fi

compression='gzip'
# extract the initramfs from the kernel
rm -rf /tmp/initramfs
kernel_repack_utils/extracter.sh -s "$x" -d /tmp/repacker/initramfs
kernel_repack_utils/repacker.sh \
	-s $x \
	-r /tmp/repacker/initramfs \
	-c $compression \
	-d /tmp/repacker/zImage

# build .tar archives for Odin

cd /tmp/repacker
tar cf $DEST zImage
cp $DEST /home/share/hardware/galaxysii/
