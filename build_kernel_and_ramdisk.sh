#!/bin/sh

# if $1 is not empty update the modules and rebuild zImage with
# the updated ramdisk


build_kernel() {
	cd linux_gt-i9000/
	test -x build_kernel.sh && bash -c ./build_kernel.sh || ./scripts/build_kernel.sh
	cd ..
}

scripts/run_generate_ramdisk.sh || exit 1
build_kernel

if test -n "$1"; then
	scripts/run_generate_ramdisk.sh || exit 1
	scripts/copy_modules_to_ramdisk.sh
	build_kernel
fi
