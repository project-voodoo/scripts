#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=/opt/toolchains/arm-2009q3/bin/arm-none-linux-gnueabi-

cd nexuss
make -j8

cp  arch/arm/boot/zImage /home/share/hardware/nexuss/
cd /home/share/hardware/nexuss/
tar cvf nexuss.tar zImage

cp nexuss.tar /home/share/voodoo-dl/nexus-s-kernel-on-galaxy-s/nsonsgs.tar
du -sh /home/share/voodoo-dl/nexus-s-kernel-on-galaxy-s/nsonsgs.tar
~/dev/voodoo/update_zip/build_unsigned_update_zip.sh -s /home/share/hardware/nexuss/zImage -d /home/share/voodoo-dl/nexus-s-kernel-on-galaxy-s/nsonsgs-unsigned-cwm-update.zip
