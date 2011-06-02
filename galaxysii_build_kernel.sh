#!/bin/sh

TAR_NAME=/home/share/hardware/galaxysii/GT-I9100_Kernel_Gingerbread-supercurio.tar

INITRAMFS_SOURCE=`readlink -f galaxysii-initramfs-modified`
INITRAMFS_TMP="/tmp/initramfs-source"


rm -rf $INITRAMFS_TMP
cp -ax $INITRAMFS_SOURCE $INITRAMFS_TMP
find $INITRAMFS_TMP -name .git -exec rm -rf {} \;

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export LOCALVERSION="-rooted"
export KBUILD_BUILD_VERSION="supercurio"

adb shell sync

cd samsung-kernel-galaxysii/
nice -n 10 make -j8 modules || exit 1
find -name '*.ko' -exec cp -av {} $INITRAMFS_TMP/lib/modules/ \;

cd $INITRAMFS_TMP
find | fakeroot cpio -H newc -o > $INITRAMFS_TMP.cpio 2>/dev/null
ls -lh $INITRAMFS_TMP.cpio
cd -

nice -n 10 make -j8 zImage  CONFIG_INITRAMFS_SOURCE="$INITRAMFS_TMP.cpio" || exit 1
cd arch/arm/boot
tar cf $TAR_NAME zImage && ls -lh $TAR_NAME
