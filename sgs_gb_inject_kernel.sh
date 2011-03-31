#!/bin/sh
./scripts/sgs_gb_run_generate_initramfs.sh
./kernel_repack_utils/repacker.sh -s ggb-kernel/zImage -d ./ -r output/voodoo-initramfs/full-lzma-loader -c gzip
