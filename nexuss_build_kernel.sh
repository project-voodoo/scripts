#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export LOCALVERSION="-ge382d80"

export KBUILD_BUILD_VERSION="Voodoo"

cd nexuss
nice -n 10 make -j8
