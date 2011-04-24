#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export LOCALVERSION="-g1d030a7"

export KBUILD_BUILD_VERSION="Voodoo"

cd linux_galaxys-cm7/
nice -n 10 make -j8
