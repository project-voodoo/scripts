#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-
export LOCALVERSION="-I9000XWJVB-CL118186"
export KBUILD_BUILD_VERSION="Voodoo"

cd linux_gt-i9000-gingerbread/
nice -n 10 make -j8
