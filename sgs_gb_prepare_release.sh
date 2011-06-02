#!/bin/bash

DEST="Voodoo-test-$1-GT-I9000"
ZIMAGE="linux_gt-i9000-gingerbread/arch/arm/boot/zImage"

if test "$1" = ""; then
	echo "please specify a name for the release, like 6.0-Gingerbread-JVH"
	exit 1
fi

cp $ZIMAGE /tmp
cd /tmp
echo
tar cvvf /home/share/voodoo-dl/test-kernels/$DEST-odin-pda.tar zImage
echo
cd - >/dev/null
./update_zip/build_unsigned_update_zip.sh -s $ZIMAGE -d /home/share/voodoo-dl/test-kernels/$DEST-unsigned-update.zip

