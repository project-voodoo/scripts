#!/bin/sh

set -x

export LOCALVERSION="-I9000XXJVO-CL182937"
export KBUILD_BUILD_VERSION="Voodoo"

cd linux_gt-i9000-gingerbread/
nice -n 10 make -j8 modules $*
find -name *.ko -exec cp -v {} ../samsung_initramfs/working-copy/lib/modules/ \;
cd ..
./scripts/run_generate_initramfs.sh
cd -
nice -n 10 make -j8 zImage CONFIG_INITRAMFS_SOURCE="/home/curio/dev/voodoo/output/voodoo-initramfs/full-lzma-loader.cpio" $*
