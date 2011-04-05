#!/bin/bash

if test "$1" = ""; then
	echo "please specify a name for the release, like 5.1-Froyo-2.2.1"
	exit 1
fi

cat linux_gt-i9000/voodoo.tar > /home/share/voodoo-dl/test-kernels/Voodoo-test-$1-GT-I9000-odin-pda.tar
./update_zip/build_unsigned_update_zip.sh -s linux_gt-i9000/zImage -d /home/share/voodoo-dl/test-kernels/Voodoo-test-$1-GT-I9000-unsigned-update.zip

