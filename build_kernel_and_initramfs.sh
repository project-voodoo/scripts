#!/bin/sh
scripts/run_generate_initramfs.sh || exit 1
cd linux_gt-i9000/
./scripts/build_kernel.sh
cd ..
