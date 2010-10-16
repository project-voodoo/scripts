#!/bin/sh

# if $1 is not empty update the modules and rebuild zImage with
# the updated ramdisk


build_kernel() {
	cd linux_gt-i9000/
	./scripts/build_kernel.sh
	cd ..
}

scripts/run_generate_ramdisk.sh
build_kernel

if test -n "$1"; then
	scripts/copy_modules_to_ramdisk.sh
	build_kernel
fi
