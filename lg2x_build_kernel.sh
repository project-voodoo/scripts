#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export LOCALVERSION=""

export KBUILD_BUILD_VERSION="Voodoo"

cd linux_lge-p990/
nice -n 10 make -j8
