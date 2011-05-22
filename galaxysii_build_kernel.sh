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

cd samsung-kernel-galaxysii/
nice -n 10 make -j8 || exit 1
find -name '*.ko' -exec cp -av {} $INITRAMFS_TMP/lib/modules/ \;
nice -n 10 make -j8 CONFIG_INITRAMFS_SOURCE="$INITRAMFS_TMP" CONFIG_INITRAMFS_ROOT_UID="1005" CONFIG_INITRAMFS_ROOT_UID="1005" || exit 1
cd arch/arm/boot
tar cf $TAR_NAME zImage && ls -lh $TAR_NAME
