#!/bin/sh

# if $1 is not empty update the modules and rebuild zImage with
# the updated initramfs


build_kernel() {
	cd linux_gt-i9000/
	test -x build_kernel.sh && bash -c ./build_kernel.sh || ./scripts/build_kernel.sh
	cd ..
}
if test -n "$1"; then
	scripts/run_generate_initramfs.sh || exit 1
	scripts/copy_modules_to_initramfs.sh
	build_kernel
else
	scripts/run_generate_initramfs.sh || exit 1
	build_kernel
fi
