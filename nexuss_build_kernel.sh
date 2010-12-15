#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=arm-linux-androideabi-

cd nexuss
make -j8

cp  arch/arm/boot/zImage /home/share/hardware/nexuss/
cd /home/share/hardware/nexuss/
tar cvf nexuss.tar zImage
