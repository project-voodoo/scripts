#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export KBUILD_BUILD_VERSION="Voodoo"

cd linux_tf101/
nice -n 20 make -j8

